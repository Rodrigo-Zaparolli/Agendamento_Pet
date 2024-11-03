// lib/controller/dashboard_controller.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:agendamento_pet/constants/dialog_helper.dart';
import 'package:agendamento_pet/domain/model/agendamento.dart';
import 'package:agendamento_pet/domain/model/clientes.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:agendamento_pet/domain/usecase/busca_cep_usecase.dart';
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'dashboard_controller.g.dart';

@injectable
class DashboardController = _DashboardControllerBase with _$DashboardController;

abstract class _DashboardControllerBase with Store {
  final FirebaseUsecase firebaseUsecase;
  final BuscaCepUseCase _buscaCepUseCase;
  final FirebaseAuth _firebaseAuth;

  _DashboardControllerBase(
    this.firebaseUsecase,
    this._buscaCepUseCase,
    this._firebaseAuth,
  );

  // Controladores para os campos de texto Cliente
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchPetController = TextEditingController();
  final TextEditingController cepController = TextEditingController();

  // Controladores para os campos de texto Pets
  final TextEditingController nomePetController = TextEditingController();
  final TextEditingController racaPetController = TextEditingController();
  final TextEditingController portePetController = TextEditingController();
  final TextEditingController nascimentoPetController = TextEditingController();
  final TextEditingController idadePetController = TextEditingController();
  final TextEditingController pesoPetController = TextEditingController();
  final TextEditingController idadeDecimalPetController =
      TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController tutorPetController = TextEditingController();

// Controladores para os campos de texto Serviço
  final TextEditingController nomeServicoController = TextEditingController();
  final TextEditingController tipoServicoController = TextEditingController();
  final TextEditingController porteServicoController = TextEditingController();
  final TextEditingController precoServicoController = TextEditingController();
  final TextEditingController descricaoServicoController =
      TextEditingController();
  final TextEditingController duracaoServicoController =
      TextEditingController();

  final dHelper = DialogHelper();

  @observable
  bool isAuthenticated = false;

  @observable
  ObservableList<Clientes> clients = ObservableList<Clientes>();

  @observable
  List<Pet> pets = [];

  @observable
  ObservableList<Agendamento> agendamentos = ObservableList<Agendamento>();

  @observable
  List<Servico> servico = [];

  @observable
  List<String> availableTimeSlots = [];

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingPet = false;

  @observable
  bool isTimeSlotEnabled = true;

  @observable
  String errorMessage = '';
  String errorMessagePet = '';

  @observable
  String? selectedClient = "";

  @observable
  Pet? selectedPet;

  @observable
  Servico? selectedServico;

  @observable
  String? selectedTimeSlot;

  @observable
  int agendamentosDia = 0;

  @observable
  int agendamentosMes = 0;

  String? selectedSexo;

  DateTime? selectedDate;

  DateTime? dataNascimento;

  List<String> occupiedSlots = [];

  final List<String> timeSlots = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '13:30',
    '14:30',
    '15:30',
    '16:30',
    '17:30',
    '18:30',
  ];

  List<String> slotsDisponiveis = [];
  List<String> horariosOcupados = [];

  String get currentUserId {
    final User? user = _firebaseAuth.currentUser;
    return user?.uid ?? '';
  }

  @action
  Future<void> cadastrarCliente({
    required BuildContext context,
    required String sexo,
    required DateTime dataNascimento,
  }) async {
    print("Iniciando cadastro de cliente...");

    // Verifique se os campos estão preenchidos corretamente
    if (!_validateFields()) {
      print("Validação de campos falhou");
      return;
    }

    try {
      final usuarioId = _firebaseAuth.currentUser?.uid;
      if (usuarioId == null) {
        throw Exception("Usuário não está logado.");
      }

      print(
          'Nome: ${nomeController.text}, Sexo: $sexo, Data de Nascimento: $dataNascimento');

      final cliente = Clientes(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: nomeController.text,
        sexo: sexo,
        dataNascimento: dataNascimento,
        endereco: enderecoController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        uf: estadoController.text,
        complemento: complementoController.text,
        cidade: cidadeController.text,
        telefone: telefoneController.text,
        userId: usuarioId,
      );

      // Chamada ao Firebase
      await firebaseUsecase.addClient(cliente, usuarioId);
      print('Cliente cadastrado com sucesso');
      clearFields();

      // Exibe um diálogo de sucesso
      await dHelper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");

      await fetchClients();
    } catch (e) {
      print("Erro ao cadastrar cliente: $e");
      errorMessage = e.toString();
      await dHelper.showErrorDialog(context, errorMessage);
    }
  }

  @action
  Future<void> searchClients(String query) async {
    isLoading = true;
    errorMessage = '';

    try {
      final userId = currentUserId;

      if (query.isEmpty) {
        await fetchClients();
        return;
      }
      final result = await firebaseUsecase.fetchClients(userId);

      clients = ObservableList.of(
        result
            .where((cliente) =>
                cliente.nome.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );

      if (clients.isEmpty) {
        errorMessage = 'Nenhum cliente encontrado para "$query".';
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar clientes: $e");
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchClients() async {
    isLoading = true;
    errorMessage = '';
    print('Iniciando fetchClients...');

    try {
      final userId = currentUserId;

      final result = await firebaseUsecase.fetchClients(userId);
      print('Firestore retornou ${result.length} clientes.');
      clients = ObservableList.of(result);

      if (clients.isEmpty) {
        errorMessage = 'Nenhum cliente cadastrado.';
        print(errorMessage);
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar clientes: $e");
    } finally {
      isLoading = false;
      print('fetchClients concluído. isLoading: $isLoading');
    }
  }

  void setSelectedClient(String clientName) {
    selectedClient = clientName;
  }

  @action
  Future<void> deleteClients(Clientes clientes, String userId) async {
    try {
      isLoading = true;
      await firebaseUsecase.deleteClient(clientes, userId);

      await fetchClients();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> searchPets(String query) async {
    isLoadingPet = true;
    errorMessage = '';

    try {
      final userId = currentUserId;
      if (query.isEmpty) {
        await fetchPets();
        return;
      }

      final result = await firebaseUsecase.fetchPets(userId);

      // Filtra os pets com base na consulta
      pets = ObservableList.of(
        result
            .where(
                (pet) => pet.nome.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );

      if (pets.isEmpty) {
        errorMessage = 'Nenhum pet encontrado para "$query".';
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar pets: $e");
    } finally {
      isLoadingPet = false;
    }
  }

  @action
  void setSelectedPet(Pet pet) {
    selectedPet = pet;
  }

  @action
  Future<void> fetchPets() async {
    isLoadingPet = true;
    errorMessagePet = '';
    print('Iniciando fetchPets...');

    try {
      final userId = currentUserId;
      final result = await firebaseUsecase.fetchPets(userId);
      print('Firestore retornou ${result.length} pets.');

      pets = ObservableList.of(result);

      if (pets.isEmpty) {
        errorMessagePet = 'Nenhum pet cadastrado para este cliente.';
        print(errorMessagePet);
      }
    } catch (e) {
      errorMessagePet = e.toString();
      print("Erro ao buscar pets: $e");
    } finally {
      isLoadingPet = false;
      print('fetchPets concluído. isLoadingPet: $isLoadingPet');
    }
  }

  @action
  Future<void> deletePets(Pet pet) async {
    try {
      isLoadingPet = true;
      await firebaseUsecase.deletePet(pet);
      await fetchPets();
    } finally {
      isLoadingPet = false;
    }
  }

  @action
  Future<void> searchCep(String cep, BuildContext context) async {
    try {
      final resultCep = await _buscaCepUseCase.call(cep);
      cidadeController.text = resultCep.localidade;
      estadoController.text = resultCep.uf;
      enderecoController.text = resultCep.logradouro;
      bairroController.text = resultCep.bairro;
    } catch (e) {
      print('Erro ao buscar CEP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cep não encontrado... Verifique !')),
      );

      // Limpa os campos se o CEP não for encontrado
      cidadeController.clear();
      estadoController.clear();
      enderecoController.clear();
      bairroController.clear();
    }
  }

  @action
  void clearFields() {
    nomeController.clear();
    dataNascimentoController.clear();
    cepController.clear();
    enderecoController.clear();
    numeroController.clear();
    bairroController.clear();
    cidadeController.clear();
    telefoneController.clear();
  }

  @action
  void clearPetFields() {
    nomePetController.clear();

    racaPetController.clear();
    portePetController.clear();
    nascimentoPetController.clear();
    idadePetController.clear();
    pesoPetController.clear();
  }

  // Método para validar os campos obrigatórios
  bool _validateFields() {
    if (nomeController.text.isEmpty ||
        dataNascimentoController.text.isEmpty ||
        enderecoController.text.isEmpty ||
        numeroController.text.isEmpty ||
        bairroController.text.isEmpty ||
        cidadeController.text.isEmpty ||
        telefoneController.text.isEmpty) {
      errorMessage = 'Por favor, preencha todos os campos obrigatórios.';
      return false;
    }
    errorMessage = '';
    return true;
  }

  @action
  Future<void> cadastrarPet({
    required BuildContext context,
    required String sexo,
    required String tipoPet,
    required String raca,
    required String porte,
    required String tutor,
  }) async {
    if (!_validatePetFields(raca, tipoPet, sexo, porte, tutor)) return;

    try {
      final usuarioId = _firebaseAuth.currentUser?.uid;
      if (usuarioId == null) {
        throw Exception("Usuário não está logado.");
      }

      final pet = Pet(
        clientId: usuarioId,
        nome: nomePetController.text,
        raca: raca,
        porte: porte,
        nascimento: nascimentoPetController.text,
        idade: idadePetController.text,
        peso: pesoPetController.text,
        sexo: sexo,
        tipo: tipoPet,
        tutor: tutor,
      );

      await firebaseUsecase.addPet(pet, usuarioId);

      print('Pet cadastrado com sucesso, ID do cliente: $usuarioId');
      clearPetFields();

      await dHelper.showSuccessDialog(
          context, "Cadastro do pet realizado com sucesso!");
      await fetchPets();
    } catch (e) {
      print("Erro ao cadastrar pet: $e");
      errorMessage = e.toString();
    }
  }

  bool _validatePetFields(
      String raca, String tipoPet, String sexo, String porte, String tutor) {
    if (nomePetController.text.isEmpty ||
        raca.isEmpty ||
        porte.isEmpty ||
        tipoPet.isEmpty ||
        sexo.isEmpty ||
        tutor.isEmpty ||
        nascimentoPetController.text.isEmpty ||
        idadePetController.text.isEmpty ||
        pesoPetController.text.isEmpty) {
      errorMessage = 'Por favor, preencha todos os campos obrigatórios.';
      return false;
    }
    errorMessage = '';
    return true;
  }

  @action
  int calcularIdade(String dataNascimento) {
    try {
      DateTime nascimento = DateFormat('dd/MM/yyyy').parse(dataNascimento);
      DateTime agora = DateTime.now();

      int idade = agora.year - nascimento.year;

      if (agora.month < nascimento.month ||
          (agora.month == nascimento.month && agora.day < nascimento.day)) {
        idade--;
      }

      return idade;
    } catch (e) {
      print("Erro ao calcular a idade: $e");
      return 0;
    }
  }

  // Carregar Agendamentos
  @action
  Future<void> carregarAgendamentos() async {
    List<Agendamento> fetchedAgendamentos =
        await firebaseUsecase.fetchAgendamentos();

    agendamentos = ObservableList<Agendamento>.of(fetchedAgendamentos);

    // Atualizar contagens
    agendamentosDia = agendamentos.where((a) => isToday(a.data)).length;
    agendamentosMes = agendamentos.where((a) => isThisMonth(a.data)).length;
  }

  bool isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  bool isThisMonth(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month;
  }

  @action
  List<String> getAvailableTimeSlots(DateTime selectedDate) {
    // Filtra os agendamentos do dia selecionado
    final agendamentosDoDia = agendamentos
        .where((a) =>
            DateFormat('dd/MM/yyyy').format(a.data) ==
            DateFormat('dd/MM/yyyy').format(selectedDate))
        .toList();

    List<String> availableSlots = [];

    // Loop pelas horas disponíveis (exceto 12h)
    for (int hour = 8; hour < 18; hour++) {
      if (hour == 12) continue; // Ignora o horário de 12h

      String currentHour = '$hour:00';
      String nextHour = '${hour + 1}:00';

      // Verifica se o horário atual ou o próximo estão ocupados
      bool isOccupied = agendamentosDoDia.any((agendamento) {
        return agendamento.hora == currentHour ||
            agendamento.hora == nextHour ||
            agendamento.horariosOcupados.contains(currentHour) ||
            agendamento.horariosOcupados.contains(nextHour);
      });

      if (!isOccupied) {
        availableSlots.add(currentHour);
      }
    }

    // Remove horários baseados na duração do serviço
    if (selectedServico?.duracao == 120) {
      availableSlots.removeWhere((slot) {
        final hourPart = int.parse(slot.split(':')[0]);
        return slot == '$hourPart:00' ||
            (hourPart < 17 && slot == '${hourPart + 1}:00');
      });
    } else if (selectedServico?.duracao == 60) {
      availableSlots
          .removeWhere((slot) => slot == '${selectedServico?.duracao}');
    }

    return availableSlots;
  }

  @action
  Future<void> salvarAgendamento(
      Agendamento agendamento, BuildContext context) async {
    try {
      // Busca os agendamentos existentes (de todos os usuários)
      final agendamentosExistentes = await firebaseUsecase.fetchAgendamentos();

      // Formata a hora do agendamento para ter sempre dois dígitos
      String formattedHoraAgendamento = agendamento.hora.padLeft(5, '0');
      DateTime horaAgendamento =
          DateTime.parse('1970-01-01 $formattedHoraAgendamento');

      // Verifica se já existe um agendamento no mesmo horário
      bool existeAgendamentoNoMesmoHorario = agendamentosExistentes.any((a) {
        String formattedHoraExistente = a.hora.padLeft(5, '0');
        DateTime horaExistente =
            DateTime.parse('1970-01-01 $formattedHoraExistente');

        // Verifica se é o mesmo dia e se o horário existe
        if (a.data.isSameDay(agendamento.data)) {
          if (a.servico.duracao == 120) {
            // Se o serviço tem duração de 120 minutos, verifica as duas horas
            return horaExistente.hour == horaAgendamento.hour ||
                horaExistente.hour == horaAgendamento.hour + 1;
          } else {
            // Para outros serviços, apenas verifica a hora
            return horaExistente.hour == horaAgendamento.hour;
          }
        }
        return false;
      });

      // Verifica a lista de horários ocupados do modelo
      bool existeHorarioOcupado = agendamentosExistentes.any((a) {
        return a.horariosOcupados.contains(formattedHoraAgendamento) ||
            (agendamento.servico.duracao == 120 &&
                a.horariosOcupados.contains('${horaAgendamento.hour + 1}:00'));
      });

      if (existeAgendamentoNoMesmoHorario || existeHorarioOcupado) {
        // Exibe o alerta de conflito
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Conflito de Agendamento"),
            content: const Text("Já existe um agendamento para este horário."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          ),
        );
      } else {
        // Gera o ID do agendamento usando o timestamp atual
        agendamento.id = DateTime.now().millisecondsSinceEpoch.toString();

        // Adiciona o horário ocupado à lista do agendamento
        if (agendamento.servico.duracao == 120) {
          agendamento.horariosOcupados.add(formattedHoraAgendamento);
          agendamento.horariosOcupados.add(
              '${horaAgendamento.hour + 1}:00'); // Adiciona o próximo horário
        } else {
          agendamento.horariosOcupados.add(formattedHoraAgendamento);
        }

        await firebaseUsecase.addAgendamento(
          agendamento,
          agendamento.userId,
          agendamento.petId,
        );

        // Adiciona o novo agendamento à lista local
        agendamentos.add(agendamento);
        clearPetFields();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: const Text("Sucesso"),
              content: const Text("Agendamento salvo com sucesso!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                )
              ]),
        );
      }
    } catch (e) {
      print("Erro ao salvar agendamento: $e");

      // Exibe o alerta de erro
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro"),
          content: Text("Erro ao salvar agendamento: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            )
          ],
        ),
      );
      rethrow;
    }
  }

  // Função para excluir agendamento
  @action
  Future<void> excluirAgendamento(Agendamento agendamento) async {
    try {
      isLoading = true;
      await firebaseUsecase.deleteAgendamento(agendamento.id!);

      agendamentos.removeWhere((a) => a.id == agendamento.id);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fecthServico() async {
    isLoading = true;
    errorMessage = '';
    print('Iniciando fetchServicos...');

    try {
      final result = await firebaseUsecase.fetchServicos();
      print('Firestore retornou ${result.length} serviços.');
      servico = ObservableList.of(result);

      if (servico.isEmpty) {
        errorMessage = 'Nenhum serviço cadastrado.';
        print(errorMessage);
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar serviços: $e");
    } finally {
      isLoading = false;
      print('fetchServico concluído. isLoading: $isLoading');
    }
  }

  @action
  Future<void> addServico(Servico servico) async {
    isLoading = true;
    try {
      await firebaseUsecase.addServico(servico);
    } catch (e) {
      isLoading = false;
      print('Erro ao adicionar serviço: $e');
      rethrow;
    }
  }

  @action
  Future<void> deleteServico(String servicoID) async {
    isLoading = true;
    try {
      await firebaseUsecase.deleteServico(servicoID);
      print('Serviço deletado com sucesso.');

      await fecthServico();
    } catch (e) {
      print('Erro ao deletar serviço: $e');
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateServico(String servicoId, Servico servico) async {
    isLoading = true;
    try {
      await firebaseUsecase.updateServico(servicoId, servico);
      print('Serviço atualizado com sucesso.');

      await fecthServico();
    } catch (e) {
      print('Erro ao atualizar serviço: $e');
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  List<Servico> getServicosPorPorte(Pet? petSelecionado) {
    if (petSelecionado == null) return [];

    return servico
        .where((servico) => servico.porte == petSelecionado.porte)
        .toList();
  }

  @action
  @action
  Future<void> searchServices(String query) async {
    isLoading = true;
    errorMessage = '';

    try {
      if (query.isEmpty) {
        // Recarrega todos os serviços e atualiza a lista servico
        final allServices = await firebaseUsecase.fetchServicos();
        servico = ObservableList.of(allServices);
        return;
      }

      // Filtra os serviços com base na query
      final result = await firebaseUsecase.fetchServicos();

      servico = ObservableList.of(
        result.where((servico) {
          final nomeMatch =
              servico.nome.toLowerCase().contains(query.toLowerCase());
          final tipoMatch =
              servico.tipo.toLowerCase().contains(query.toLowerCase());
          final porteMatch =
              servico.porte.toLowerCase().contains(query.toLowerCase());

          return nomeMatch || tipoMatch || porteMatch;
        }).toList(),
      );

      if (servico.isEmpty) {
        errorMessage = 'Nenhum serviço encontrado para "$query".';
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar serviços: $e");
    } finally {
      isLoading = false;
    }
  }
}
