// lib/controller/dashboard_controller.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:agendamento_pet/constants/app_constanst.dart';
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

// Controladores para os campos de texto Serviço

  final TextEditingController nomeServicoController = TextEditingController();
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
  bool isLoading = false;

  @observable
  bool isLoadingPet = false;

  @observable
  String errorMessage = '';
  String errorMessagePet = '';

  @observable
  String? selectedClient = "";

  @observable
  Pet? selectedPet;

  @observable
  Servico? selectedServico;

  String? selectedSexo;

  DateTime? selectedDate;

  DateTime? dataNascimento;

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

      // Log dos valores antes da criação do cliente
      print(
          'Nome: ${nomeController.text}, Sexo: $sexo, Data de Nascimento: $dataNascimento');

      final cliente = Clientes(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: nomeController.text,
        sexo: sexo,
        dataNascimento:
            dataNascimento, // Certifique-se de que isso está no modelo
        endereco: enderecoController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        telefone: telefoneController.text,
        userId: usuarioId,
      );

      // Chamada ao Firebase
      await firebaseUsecase.addClients(cliente, usuarioId);
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
        print(errorMessage);
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
    required String clienteId,
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
        clienteId: clienteId,
      );

      await firebaseUsecase.addPet(pet, clienteId);
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

  // Carregar Agendamentos
  @action
  Future<void> carregarAgendamentos() async {
    isLoading = true;
    try {
      final fetchedAgendamentos = await firebaseUsecase.fetchAgendamentos();

      if (fetchedAgendamentos.isNotEmpty) {
        agendamentos.clear();
        agendamentos.addAll(fetchedAgendamentos);
      } else {
        print("Nenhum agendamento encontrado.");
      }
    } catch (e) {
      print("Erro ao carregar agendamentos: $e");
    } finally {
      isLoading = false;
    }
  }

  // Verificar disponibilidade
  @action
  Future<bool> verificarDisponibilidade(DateTime dataHora) async {
    try {
      final fetchedAgendamentos = await firebaseUsecase.fetchAgendamentos();
      return fetchedAgendamentos
          .every((agendamento) => agendamento.dataHora != dataHora);
    } catch (e) {
      print("Erro ao verificar disponibilidade: $e");
      return false;
    }
  }

  @action
  Future<void> salvarAgendamento(
      Agendamento agendamento, BuildContext context) async {
    try {
      // Verifica se já existe um agendamento no mesmo horário
      bool existeAgendamentoNoMesmoHorario = agendamentos
          .any((a) => a.dataHora.isAtSameMomentAs(agendamento.dataHora));

      if (existeAgendamentoNoMesmoHorario) {
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
              ),
            ],
          ),
        );
      } else {
        await firebaseUsecase.addAgendamento(
          agendamento,
          agendamento.userId,
          agendamento.petId,
        );
        agendamentos.add(agendamento);

        // Exibe uma mensagem de sucesso
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sucesso"),
            content: const Text("Agendamento salvo com sucesso!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
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
            ),
          ],
        ),
      );
      throw e;
    }
  }

  // Função para excluir agendamento
  @action
  Future<void> excluirAgendamento(Agendamento agendamento) async {
    try {
      isLoading = true;
      await firebaseUsecase.deleteAgendamento(agendamento.id!);

      // Remove o agendamento da lista local
      agendamentos.removeWhere((a) => a.id == agendamento.id);
    } catch (e) {
      // Tratar erro, exibir mensagem de erro se necessário
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
      final result = await firebaseUsecase.fetchServico();
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
}
