// lib/controller/dashboard_controller.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:agendamento_pet/constants/app_constanst.dart';
import 'package:agendamento_pet/constants/dialog_helper.dart';
import 'package:agendamento_pet/domain/model/clientes.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/domain/usecase/busca_cep_usecase.dart';
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart';
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

  _DashboardControllerBase(
    this.firebaseUsecase,
    this._buscaCepUseCase,
  );

  // Controladores para os campos de texto Cliente
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController cepController = TextEditingController();

  // Controladores para os campos de texto Pets
  final TextEditingController nomePetController = TextEditingController();
  final TextEditingController racaPetController = TextEditingController();
  final TextEditingController portePetController = TextEditingController();
  final TextEditingController nascimentoPetController = TextEditingController();
  final TextEditingController idadePetController = TextEditingController();
  final TextEditingController pesoPetController = TextEditingController();
  final TextEditingController idadeDecimalPetController = TextEditingController();
  final TextEditingController tutorController= TextEditingController();
 // final TextEditingController searchController = TextEditingController();

  final dHelper = DialogHelper();

  @observable
  bool isAuthenticated = false;

  @observable
  ObservableList<Clientes> clients = ObservableList<Clientes>();

  @observable
  ObservableList<Pet> pets = ObservableList<Pet>();

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingPet = false;

  @observable
  String errorMessage = '';
  String errorMessagePet = '';

  @action
  Future<void> cadastrarCliente({
    required BuildContext context,
    required String sexo,
  }) async {
    if (!_validateFields()) return; // Validação dos campos

    try {
      final cliente = Clientes(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: nomeController.text,
        sexo: sexo,
        idade: idadeController.text,
        endereco: enderecoController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        telefone: telefoneController.text,
      );

      await firebaseUsecase.addClients(cliente);
      print('Cliente cadastrado com sucesso');
      clearFields();

      await dHelper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");

      await fetchClients();
    } catch (e) {
      print("Erro ao cadastrar cliente: $e");
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> searchClients(String query) async {
    isLoading = true;
    errorMessage = '';

    try {
      if (query.isEmpty) {
        await fetchClients();
        return;
      }

      final result = await firebaseUsecase.fetchClients();

      // Filtra os clientes com base na consulta
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
      final result = await firebaseUsecase.fetchClients();
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

    @action
  Future<void> searchPets(String query) async {
    isLoadingPet = true;
    errorMessage = '';

    try {
      if (query.isEmpty) {
        await fetchPets();
        return;
      }

      final result = await firebaseUsecase.fetchPets();

      // Filtra os pets com base na consulta
      pets = ObservableList.of(
        result
            .where((pet) =>
                pet.nome.toLowerCase().contains(query.toLowerCase()))
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

  //@action
  //Future<void> fetchPets() async {
   // isLoadingPet = true;
   // errorMessagePet = '';

   // try {
    //  final result = await firebaseUsecase.fetchPets();
    //  pets = ObservableList.of(result);

    //  if (pets.isEmpty) {
     //   errorMessagePet = 'Nenhum pet cadastrado.';
    //  }
  //  } catch (e) {
   //   errorMessagePet = e.toString();
 //     print("Erro ao buscar pets: $e");
  //  } finally {
   //   isLoadingPet = false;
   // }
//  }

  @action
  Future<void> fetchPets() async {
    isLoadingPet = true;
    errorMessage = '';
    print('Iniciando fetchPets...');

    try {
      final result = await firebaseUsecase.fetchPets();
      print('Firestore retornou ${result.length} pets.');
      pets = ObservableList.of(result);

      if (pets.isEmpty) {
        errorMessage = 'Nenhum pet cadastrado.';
        print(errorMessage);
      }
    } catch (e) {
      errorMessage = e.toString();
      print("Erro ao buscar pets: $e");
    } finally {
      isLoadingPet = false;
      print('fetchPets concluído. isLoadingPet: $isLoadingPet');
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
    idadeController.clear();
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
    tutorController.clear();
  }

  // Método para validar os campos obrigatórios
  bool _validateFields() {
    if (nomeController.text.isEmpty ||
        idadeController.text.isEmpty ||
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
      final pet = Pet(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: nomePetController.text,
        raca: raca,
        porte: porte,
        nascimento: nascimentoPetController.text,
        idade: idadePetController.text,
        peso: pesoPetController.text,
        sexo: sexo,
        tipo: tipoPet,
        tutor: tutorController.text,
      );

      await firebaseUsecase.addPet(pet);
      print('Pet cadastrado com sucesso');
      clearPetFields();

      // Exibe um diálogo de sucesso
      await dHelper.showSuccessDialog(
          context, "Cadastro do pet realizado com sucesso!");
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
      // Converte a string da data de nascimento para um objeto DateTime
      DateTime nascimento = DateFormat('dd/MM/yyyy').parse(dataNascimento);
      DateTime agora = DateTime.now();

      // Calcula a diferença em anos
      int idade = agora.year - nascimento.year;

      // Ajusta se o aniversário ainda não ocorreu neste ano
      if (agora.month < nascimento.month ||
          (agora.month == nascimento.month && agora.day < nascimento.day)) {
        idade--;
      }

      return idade;
    } catch (e) {
      print("Erro ao calcular a idade: $e");
      return 0; // Retorna 0 ou uma outra lógica de erro, conforme necessário
    }
  }

  // @action
  // Future<void> deleteClient(String clientId, BuildContext context) async {
  //   try {
  //     // Chama a função do use case para excluir o cliente do Firebase
  //     await firebaseUsecase.deleteClient(clientId);
  //     print('Cliente excluído com sucesso');

  //     // Atualiza a lista de clientes após a exclusão
  //     await fetchClients();

  //     // Exibe um diálogo de sucesso
  //     await dHelper.showSuccessDialog(context, "Cliente excluído com sucesso!");
  //   } catch (e) {
  //     print("Erro ao excluir cliente: $e");
  //     errorMessage = e.toString();
  //     await dHelper.showErrorDialog(
  //         context, "Erro ao excluir cliente: $errorMessage");
  //   }
  // }

  @action
  Future<void> deletePet(String petId) async {
    isLoading = true;
    try {
      await firebaseUsecase.deletePet(petId);
      print('Pet excluído com sucesso');

      await fetchPets();

      await dHelper.showSuccessDialog(ctx, "Pet excluído com sucesso!");
    } catch (e) {
      print("Erro ao excluir pet: $e");
      errorMessagePet = e.toString();
      await dHelper.showErrorDialog(
          ctx, "Erro ao excluir pet: $errorMessagePet");
    } finally {
      isLoading = false;
    }
  }
}
