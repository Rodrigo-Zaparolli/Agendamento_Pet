import 'package:agendamento_pet/domain/model/agendamento.dart';
import 'package:agendamento_pet/domain/model/clientes.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:agendamento_pet/domain/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

abstract class FirestoreRepository {
  // Usuário
  Future<void> addUser(Usuario usuario);
  Future<void> changePassword(String newPassword);
  Future<Usuario?> getUserDetails(String userId);
  Future<void> updateUserDetails(Usuario usuario);

  // Clientes
  Future<List<Clientes>> fetchClients();
  Future<void> addClients(Clientes client);
  Future<void> deleteClients(Clientes client);

  // Pets
  Future<void> addPets(Pet pet);
  Future<List<Pet>> fetchPets(String clientId);
  Future<void> deletePets(Pet pet);

  // Agendamentos
  Future<void> addAgendamento(Agendamento agendamento, String petId);
  Future<List<Agendamento>> fetchAgendamentos(
      {bool paraVerificacaoConflito = false});
  Future<void> deleteAgendamento(String agendamentoId);
  Future<void> updateAgendamento(
      String agendamentoId, Agendamento agendamento, String motivo);
  Future<List<Agendamento>> fetchAgendamentosCancelados();

  // Serviços
  Future<void> addServico(Servico servico);
  Future<List<Servico>> fetchServico();
  Future<void> deleteServico(String servicoId);
  Future<void> updateServico(String servicoId, Servico servico);
}

@Injectable(as: FirestoreRepository)
class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FirestoreRepositoryImpl(this.firestore, this.auth);

  @override
  Future<void> addUser(Usuario usuario) async {
    try {
      await firestore.collection('users').doc(usuario.id).set(usuario.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Usuario?> getUserDetails(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return Usuario.fromJson(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserDetails(Usuario usuario) async {
    try {
      await firestore
          .collection('users')
          .doc(usuario.id)
          .update(usuario.toJson());

      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await currentUser.verifyBeforeUpdateEmail(usuario.email);
        await currentUser.updateProfile(
            displayName: usuario.name, photoURL: usuario.photoURL);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Clientes>> fetchClients() async {
    String? userId = auth.currentUser?.uid;
    bool isManager = await isUserManager(userId);

    final QuerySnapshot querySnapshot = isManager
        ? await firestore
            .collection('clientes')
            .get() // Acesso total para gerentes
        : await firestore
            .collection('clientes')
            .where('userId', isEqualTo: userId)
            .get(); // Apenas clientes do usuário

    return querySnapshot.docs.map((doc) => Clientes.fromDocument(doc)).toList();
  }

  Future<bool> isUserManager(String? userId) async {
    if (userId == null) return false;

    final docSnapshot = await firestore.collection('users').doc(userId).get();
    return docSnapshot.exists && docSnapshot['role'] == 'manager';
  }

  @override
  Future<void> addClients(Clientes client) async {
    try {
      String? userId = auth.currentUser?.uid;
      client.userId = userId!;
      await firestore.collection('clientes').add(client.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteClients(Clientes client) async {
    try {
      await firestore.collection('clientes').doc(client.id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addPets(Pet pet) async {
    try {
      if (pet.id != null) {
        await firestore.collection('pets').doc(pet.id).delete();
      }

      // Adicionar o pet com as novas informações
      DocumentReference docRef = await firestore.collection('pets').add({
        ...pet.toJson(),
        'clientId': pet.clientId,
      });

      // Atualizar o campo 'id' com o ID do novo documento
      await docRef.update({'id': docRef.id});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Pet>> fetchPets(String clientId) async {
    try {
      String? userId = auth.currentUser?.uid;
      bool isManager = await isUserManager(userId);

      final QuerySnapshot snapshot = isManager
          ? await firestore
              .collection('pets')
              .get() // Acesso total para gerentes
          : await firestore
              .collection('pets')
              .where('clientId', isEqualTo: clientId)
              .get(); // Apenas pets do cliente

      return snapshot.docs.map((doc) {
        Pet pet = Pet.fromDocument(doc);
        pet.id = doc.id; // Atribui o ID ao pet
        return pet;
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePets(Pet pet) async {
    try {
      await firestore.collection('pets').doc(pet.id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addAgendamento(Agendamento agendamento, String petId) async {
    try {
      await firestore.collection('agendamentos').add(agendamento.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Agendamento>> fetchAgendamentos(
      {bool paraVerificacaoConflito = false}) async {
    try {
      String? userId = auth.currentUser?.uid;
      bool isManager = await isUserManager(userId);

      QuerySnapshot snapshot;

      if (isManager || paraVerificacaoConflito) {
        snapshot = await firestore
            .collection('agendamentos')
            .where('motivoCancel', isEqualTo: "")
            .get();
      } else {
        // Usuários não-gerentes acessam apenas seus próprios agendamentos
        snapshot = await firestore
            .collection('agendamentos')
            .where('userId', isEqualTo: userId)
            .where('motivoCancel',
                isEqualTo: "") // Filtra agendamentos com motivoCancel vazio
            .get();
      }

      List<Agendamento> agendamentos =
          snapshot.docs.map((doc) => Agendamento.fromDocument(doc)).toList();

      // Cria um formatador de hora para garantir o formato correto
      final timeFormat = DateFormat("HH:mm");

      // Ordena os agendamentos por data e hora
      agendamentos.sort((a, b) {
        int dateComparison = a.data.compareTo(b.data);

        if (dateComparison == 0) {
          try {
            DateTime horaA = timeFormat.parse(a.hora);
            DateTime horaB = timeFormat.parse(b.hora);

            // Ajusta a data para comparação
            DateTime dateTimeA = DateTime(1970, 1, 1, horaA.hour, horaA.minute);
            DateTime dateTimeB = DateTime(1970, 1, 1, horaB.hour, horaB.minute);

            return dateTimeA.compareTo(dateTimeB);
          } catch (e) {
            print("Erro ao comparar horas: $e");
            return 0;
          }
        }

        return dateComparison;
      });

      if (agendamentos.isEmpty) {
        print("Nenhum agendamento encontrado.");
      }

      return agendamentos;
    } catch (e) {
      print("Erro ao buscar agendamentos: $e");
      rethrow;
    }
  }

  @override
  Future<List<Agendamento>> fetchAgendamentosCancelados() async {
    try {
      String? userId = auth.currentUser?.uid;
      bool isManager = await isUserManager(userId);

      QuerySnapshot snapshot;

      if (isManager) {
        // Gerentes podem acessar todos os agendamentos cancelados
        snapshot = await firestore
            .collection('agendamentos')
            .where('motivoCancel',
                isNotEqualTo: "") // Filtra agendamentos cancelados
            .get();
      } else {
        // Usuários não-gerentes acessam apenas seus próprios agendamentos cancelados
        snapshot = await firestore
            .collection('agendamentos')
            .where('userId', isEqualTo: userId)
            .where('motivoCancel',
                isNotEqualTo: "") // Filtra agendamentos cancelados
            .get();
      }

      List<Agendamento> agendamentos =
          snapshot.docs.map((doc) => Agendamento.fromDocument(doc)).toList();

      // Cria um formatador de hora para garantir o formato correto
      final timeFormat = DateFormat("HH:mm");

      // Ordena os agendamentos por data e hora
      agendamentos.sort((a, b) {
        int dateComparison = a.data.compareTo(b.data);

        if (dateComparison == 0) {
          try {
            DateTime horaA = timeFormat.parse(a.hora);
            DateTime horaB = timeFormat.parse(b.hora);

            // Ajusta a data para comparação
            DateTime dateTimeA = DateTime(1970, 1, 1, horaA.hour, horaA.minute);
            DateTime dateTimeB = DateTime(1970, 1, 1, horaB.hour, horaB.minute);

            return dateTimeA.compareTo(dateTimeB);
          } catch (e) {
            print("Erro ao comparar horas: $e");
            return 0;
          }
        }

        return dateComparison;
      });

      if (agendamentos.isEmpty) {
        print("Nenhum agendamento cancelado encontrado.");
      }

      return agendamentos;
    } catch (e) {
      print("Erro ao buscar agendamentos cancelados: $e");
      rethrow;
    }
  }

// Atualiza a lista de horários ocupados
  Future<List<String>> fetchOccupiedSlots(DateTime selectedDate) async {
    try {
      // Obtenha todos os agendamentos do dia selecionado, com motivoCancel vazio
      final QuerySnapshot snapshot = await firestore
          .collection('agendamentos')
          .where('data', isEqualTo: selectedDate)
          .where('motivoCancel', isEqualTo: null)
          .get();

      List<String> occupiedSlots = [];

      for (var doc in snapshot.docs) {
        final Agendamento agendamento = Agendamento.fromDocument(doc);
        occupiedSlots.addAll(agendamento.horariosOcupados);
        occupiedSlots
            .add(agendamento.hora); // Se necessário adicionar a hora também
      }

      return occupiedSlots;
    } catch (e) {
      print("Erro ao buscar horários ocupados: $e");
      rethrow;
    }
  }

  String formatHora(String hora) {
    // Supondo que o formato correto seja "HH:mm"
    if (!RegExp(r'^\d{1,2}:\d{2}$').hasMatch(hora)) {
      throw FormatException('Hora inválida: $hora');
    }
    return hora;
  }

  @override
  Future<void> deleteAgendamento(String agendamentoId) async {
    try {
      await firestore.collection('agendamentos').doc(agendamentoId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateAgendamento(
      String agendamentoId, Agendamento agendamento, String motivo) async {
    await FirebaseFirestore.instance
        .collection('agendamentos')
        .doc(agendamentoId)
        .update({
      'motivoCancel': motivo,
      'cancelledAt': DateTime.now(),
    });
  }

  @override
  Future<void> addServico(Servico servico) async {
    await FirebaseFirestore.instance
        .collection('servicos')
        .add(servico.toJson());
  }

  @override
  Future<void> deleteServico(String servicoId) async {
    await FirebaseFirestore.instance
        .collection('servicos')
        .doc(servicoId)
        .delete();
  }

  @override
  Future<List<Servico>> fetchServico() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('servicos').get();

    return snapshot.docs.map((doc) => Servico.fromDocument(doc)).toList();
  }

  @override
  Future<void> updateServico(String servicoId, Servico servico) async {
    await FirebaseFirestore.instance
        .collection('servicos')
        .doc(servicoId)
        .update(servico.toJson());
  }
}
