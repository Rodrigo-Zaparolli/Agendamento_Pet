// lib/controller/dashboard_controller.dart

// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api, unnecessary_null_comparison

import 'package:agendamento_pet/constants/app_shared_preferences.dart';
import 'package:agendamento_pet/constants/dialog_helper.dart';
import 'package:agendamento_pet/domain/model/agendamento.dart';
import 'package:agendamento_pet/domain/model/clientes.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:agendamento_pet/domain/usecase/busca_cep_usecase.dart';
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

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
  final TextEditingController emailController = TextEditingController();
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
  final sHandler = AppSharedPreferences();

  @observable
  String sexoSelecionado = 'Escolha';

  @observable
  String tipoPetSelecionado = 'Escolha';

  @observable
  String tipoPorteSelecionado = 'Escolha';

  @observable
  String racaSelecionada = 'Escolha';

  @observable
  String porteSelecionado = 'Escolha';

  @observable
  String tutorSelecionado = 'Escolha';

  @observable
  bool isAuthenticated = false;

  @observable
  String petIdToUpdate = "";

  @observable
  ObservableList<Clientes> clients = ObservableList<Clientes>();

  @observable
  ObservableList<Pet> pets = ObservableList.of([]);

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
  bool isLoadingSearchPet = false;

  @observable
  bool isTimeSlotEnabled = true;

  @observable
  bool isUpdateClient = false;

  @observable
  bool isUpdatePet = false;

  @observable
  String? currentClientUserId;

  @observable
  String role = "";

  @observable
  String? currentClientId;

  @observable
  List<String> racasSelecionadas = [];

  List<Pet> filteredPets = [];

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

  @observable
  int agendamentosCanceladosMes = 0;

  String? selectedSexo = 'Escolha';

  DateTime? selectedDate;

  DateTime? dataNascimento;

  List<String> occupiedSlots = [];

  List<String> slotsDisponiveis = [];

  List<String> horariosOcupados = [];

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

  final Map<String, List<String>> porte = {
    'Cão': [
      'Pequeno',
      'Médio',
      'Grande',
    ],
    'Gato': [
      'Pequeno, de 2 a 4 kg',
      'Médio, de 4 a 6 kg',
      'Grande, acima de 6 kg',
    ],
  };

  final Map<String, List<String>> portePequeno = {
    'Cão': [
      'Affenpinscher',
      'Bichon Frisé',
      'Boston Terrier',
      'Cavalier King Charles Spaniel',
      'Chihuahua',
      'Cocker Spaniel Americano',
      'Dachshund (Teckel)',
      'Jack Russell Terrier',
      'Lhasa Apso',
      'Maltês',
      'Papillon',
      'Pekingese',
      'Pomeranian (Spitz Alemão Anão)',
      'Poodle Toy',
      'Pug',
      'Shih Tzu',
      'Silky Terrier',
      'Welsh Corgi Pembroke',
      'West Highland White Terrier',
      'Yorkshire Terrier',
    ],
    'Gato': [
      'Singapura',
      'Cornish Rex',
      'Munchkin',
      'Devon Rex',
      'Sphynx',
    ],
  };

  final Map<String, List<String>> porteMedio = {
    'Cão': [
      'American Staffordshire Terrier',
      'Australian Shepherd',
      'Basenji',
      'Beagle',
      'Border Collie',
      'Bull Terrier',
      'Bulldog Francês',
      'Bulldog Inglês',
      'Cocker Spaniel Inglês',
      'Dálmata',
      'Poodle Médio',
      'Schnauzer Miniatura',
      'Staffordshire Bull Terrier',
      'Shiba Inu',
      'Shetland Sheepdog',
      'Shar-Pei',
      'Whippet',
      'Wheaten Terrier',
    ],
    'Gato': [
      'Siamês',
      'Abyssinian',
      'Birmanês',
      'American Shorthair',
      'British Shorthair',
      'Persa',
      'Scottish Fold',
    ],
  };

  final Map<String, List<String>> porteGrande = {
    'Cão': [
      'Akita Inu',
      'Bernese Mountain Dog',
      'Boxer',
      'Bullmastiff',
      'Cane Corso',
      'Collie',
      'Dogue Alemão',
      'Fila Brasileiro',
      'Golden Retriever',
      'Dálmata',
      'Golden Retriever',
      'Labrador Retriever',
      'Mastiff',
      'Pastor Alemão',
      'Pastor Belga',
      'Rottweiler',
      'Samoyed',
      'São Bernardo',
      'Siberian Husky',
      'Terra Nova (Newfoundland)',
      'Weimaraner',
      'Wolfhound Irlandês',
    ],
    'Gato': [
      'Maine Coon',
      'Ragdoll',
      'BirmNorueguês da Florestaanês',
      'Savannah',
      'Siberiano',
    ],
  };

  final Map<String, List<String>> racas = {
    'Cão': [
      'Labrador',
      'Poodle',
      'Bulldog',
      'Beagle',
      'Golden Retriever',
      'Spitz',
      'Shih tzu',
    ],
    'Gato': [
      'Persa',
      'Siamês',
      'Bengal',
      'Sphynx',
    ],
  };

  String get currentUserId {
    final User? user = _firebaseAuth.currentUser;
    return user?.uid ?? '';
  }

  String get currentUserEmail {
    final User? user = _firebaseAuth.currentUser;
    return user?.email ?? '';
  }

  getUserDetails() async {
    isLoading = true;
    role = await sHandler.readPreferences("role");
    isLoading = false;
  }

  final maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final maskCepFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  @action
  Future<void> cadastrarCliente({
    required BuildContext context,
    required String sexo,
    required DateTime dataNascimento,
  }) async {
    isLoading = true;
    print("Iniciando cadastro de cliente...");

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

      final existingClients = await firebaseUsecase.fetchClients(usuarioId);
      final currentUserClients = existingClients
          .where((client) => client.userId == usuarioId)
          .toList();

      if (currentUserClients.isNotEmpty) {
        for (var client in currentUserClients) {
          await firebaseUsecase.deleteClient(client, usuarioId);
          print("Cliente com ID ${client.id} excluído.");
        }
      }

      // Criação de novo cliente
      final cliente = Clientes(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: nomeController.text,
        sexo: sexo,
        dtCadastro: DateTime.now(),
        nascimento: dataNascimento,
        endereco: enderecoController.text,
        email: emailController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cep: cepController.text,
        uf: estadoController.text,
        complemento: complementoController.text,
        cidade: cidadeController.text,
        telefone: telefoneController.text,
        userId: usuarioId,
      );

      // Chamada ao Firebase para adicionar o novo cliente
      await firebaseUsecase.addClient(cliente, usuarioId);
      print('Cliente cadastrado com sucesso');
      clearFields();

      await dHelper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");
      await fetchClients();
      isLoading = false;
    } catch (e) {
      print("Erro ao cadastrar cliente: $e");
      errorMessage = e.toString();
      await dHelper.showErrorDialog(context, errorMessage);
      isLoading = false;
    }
  }

  void preencherCamposCliente(Clientes clients) {
    currentClientUserId = clients.id;
    nomeController.text = clients.nome;
    selectedSexo = clients.sexo;
    dataNascimentoController.text =
        DateFormat("dd/MM/yyyy").format(clients.nascimento);
    cidadeController.text = clients.cidade;
    estadoController.text = clients.uf;
    enderecoController.text = clients.endereco;
    emailController.text = clients.email;
    numeroController.text = clients.numero;
    complementoController.text = clients.complemento;
    bairroController.text = clients.bairro;
    cepController.text = clients.cep;
    telefoneController.text = clients.telefone;
    currentClientId = clients.userId;
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
    isLoadingSearchPet = true;
    errorMessage = '';

    try {
      final userId = currentUserId;
      if (query.isEmpty) {
        await fetchPets();
        return;
      }

      final result = await firebaseUsecase.fetchPets(userId);

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
      isLoadingSearchPet = false;
    }
  }

  void initFilteredPets() {
    filteredPets = pets;
  }

  @action
  void setSelectedSexo(String sexo) {
    selectedSexo = sexo;
  }

  @action
  void setSelectedPet(Pet pet) {
    selectedPet = pet;
    selectedSexo = pet.sexo;
  }

  @action
  Future<void> fetchPets() async {
    isLoadingSearchPet = true;
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
      isLoadingSearchPet = false;
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
    emailController.clear();
    numeroController.clear();
    bairroController.clear();
    cidadeController.clear();
    telefoneController.clear();
    complementoController.clear();
  }

  void clearPetFields() {
    nomePetController.clear();
    nascimentoPetController.clear();
    idadePetController.clear();
    pesoPetController.clear();

    racaSelecionada = 'Escolha';
    porteSelecionado = 'Escolha';
    tipoPetSelecionado = 'Escolha';
    sexoSelecionado = 'Escolha';
    tutorSelecionado = "Escolha";
  }

  void clearAgendamentoFields() {
    racaPetController.clear();
    nomePetController.clear();
    idadePetController.clear();
    pesoPetController.clear();
    selectedSexo = 'Escolha';
    selectedServico = null;
    selectedDate = null;
    selectedTimeSlot = null;
  }

  void restoreInitialDateField() {
    final initialDate = DateTime.now();
    selectedDate = initialDate;
    dataController.text = "dd/MM/yyyy";
    selectedTimeSlot = null;
  }

  bool _validateFields() {
    if (nomeController.text.isEmpty ||
        dataNascimentoController.text.isEmpty ||
        enderecoController.text.isEmpty ||
        emailController.text.isEmpty ||
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

  void preencherCamposPet(Pet pet) {
    currentClientUserId = pet.id;

    // Atualizar os observables com os valores do pet
    sexoSelecionado = pet.sexo;
    tipoPetSelecionado = pet.tipo;
    racaSelecionada = pet.raca;
    porteSelecionado = pet.porte;
    tutorSelecionado = pet.tutor;

    // Atualizar os TextEditingController com os valores do pet
    nomePetController.text = pet.nome;
    nascimentoPetController.text =
        DateFormat("dd/MM/yyyy").format(pet.nascimento);

    calcularIdadePet(DateFormat("dd/MM/yyyy").format(pet.nascimento));

    idadePetController.text = pet.idade;
    pesoPetController.text = pet.peso;

    petIdToUpdate = pet.id!;

    // Atualizar as raças com base no tipo e porte
    atualizarRacas();
  }

  void atualizarRacas() {
    // Atualiza as raças com base no tipo de pet e no porte selecionado
    if (porteSelecionado == 'Pequeno' ||
        porteSelecionado == 'Pequeno, de 2 a 4 kg') {
      racasSelecionadas = portePequeno[tipoPetSelecionado] ?? [];
    } else if (porteSelecionado == 'Médio' ||
        porteSelecionado == 'Médio, de 4 a 6 kg') {
      racasSelecionadas = porteMedio[tipoPetSelecionado] ?? [];
    } else if (porteSelecionado == 'Grande' ||
        porteSelecionado == 'Grande, acima de 6 kg') {
      racasSelecionadas = porteGrande[tipoPetSelecionado] ?? [];
    }

    // Se a raça selecionada não estiver na nova lista, redefine para 'Escolha'
    if (!racasSelecionadas.contains(racaSelecionada)) {
      racaSelecionada = 'Escolha';
    }
  }

  void calcularIdadePet(String? data) {
    if (data != null && data.isNotEmpty) {
      final DateTime nascimento = DateFormat('dd/MM/yyyy').parse(data);
      final DateTime agora = DateTime.now();

      int idadeAnos = agora.year - nascimento.year;
      int idadeMeses = agora.month - nascimento.month;
      int idadeDias = agora.day - nascimento.day;

      if (idadeMeses < 0 || (idadeMeses == 0 && idadeDias < 0)) {
        idadeAnos--;
        idadeMeses += 12;
      }

      int totalMeses = idadeAnos * 12 + idadeMeses;

      if (totalMeses == 0) {
        idadePetController.text = 'menos de um mês';
      } else if (idadeAnos == 0) {
        idadePetController.text = '$totalMeses meses';
      } else {
        idadePetController.text = '$idadeAnos anos e $idadeMeses meses';
      }

      double idadeDecimal = totalMeses / 12.0;
      idadeDecimalPetController.text = idadeDecimal.toStringAsFixed(1);
    } else {
      idadePetController.clear();
      idadeDecimalPetController.clear();
    }
  }

  @action
  Future<void> cadastrarPet({
    required BuildContext context,
    required String sexo,
    required String tipoPet,
    required String raca,
    required String porte,
    required String tutor,
    required DateTime dataNascimentoPet,
  }) async {
    isLoadingPet = true;
    if (!_validatePetFields(raca, tipoPet, sexo, porte, tutor)) return;

    try {
      final usuarioId = _firebaseAuth.currentUser?.uid;
      if (usuarioId == null) {
        throw Exception("Usuário não está logado.");
      }

      // Obter todos os pets do usuário logado
      final existingPets = await firebaseUsecase.fetchPets(usuarioId);

      // Verificar se estamos atualizando um pet existente
      if (isUpdatePet) {
        final petToUpdate = existingPets.firstWhere(
          (pet) => pet.id == petIdToUpdate,
        );

        if (petToUpdate != null) {
          await firebaseUsecase.deletePet(petToUpdate);
        } else {
          print("Pet a ser atualizado não encontrado.");
          return;
        }
      } else {
        // Caso não seja uma atualização, impedir cadastro duplicado
        final existingPetsWithSameAttributes = existingPets
            .where((pet) =>
                pet.nome == nomePetController.text &&
                pet.tipo == tipoPet &&
                pet.tutor == tutor)
            .toList();

        if (existingPetsWithSameAttributes.isNotEmpty) {
          print("Um pet com esses atributos já existe.");
          await dHelper.showErrorDialog(context,
              "Já existe um pet com essas características cadastrado.");
          return;
        }
      }

      // Criar o novo objeto Pet
      final pet = Pet(
        clientId: usuarioId,
        nome: nomePetController.text,
        raca: raca,
        porte: porte,
        nascimento: dataNascimentoPet,
        dtCadastro: DateTime.now(),
        idade: idadePetController.text,
        peso: pesoPetController.text,
        sexo: sexo,
        tipo: tipoPet,
        tutor: tutor,
      );

      // Adicionar o novo pet
      await firebaseUsecase.addPet(pet);

      print('Pet cadastrado com sucesso, ID do cliente: $usuarioId');
      clearPetFields();

      // Mostrar mensagem de sucesso
      await dHelper.showSuccessDialog(
          context, "Cadastro do pet realizado com sucesso!");

      // Atualizar lista de pets
      await fetchPets();

      // Resetar o estado de atualização
      isUpdatePet = false;
      isLoadingPet = false;
      petIdToUpdate = "";
    } catch (e) {
      print("Erro ao cadastrar pet: $e");
      errorMessage = e.toString();
      isLoadingPet = false;
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
    isLoading = true;
    List<Agendamento> fetchedAgendamentos =
        await firebaseUsecase.fetchAgendamentos();

    agendamentos = ObservableList<Agendamento>.of(fetchedAgendamentos);

    // Atualizar contagens
    agendamentosDia = agendamentos.where((a) => isToday(a.data)).length;
    agendamentosMes = agendamentos.where((a) => isThisMonth(a.data)).length;

    // Contagem dos agendamentos cancelados no mês
    isLoading = false;
  }

  @action
  Future<void> carregarAgendamentosCancelados() async {
    List<Agendamento> fetchedAgendamentos =
        await firebaseUsecase.fetchAgendamentosCancelados();

    agendamentos = ObservableList<Agendamento>.of(fetchedAgendamentos);

    agendamentosCanceladosMes =
        agendamentos.where((a) => isThisMonth(a.data)).length;
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
  Future<List<String>> getAvailableTimeSlots(DateTime selectedDate) async {
    try {
      // Busca agendamentos no Firestore para a data selecionada
      final agendamentosDoDia = await firebaseUsecase.fetchAgendamentos(
          paraVerificacaoConflito: true);

      // Filtra apenas os agendamentos do dia especificado
      final agendamentosParaData = agendamentosDoDia.where((a) {
        return DateFormat('dd/MM/yyyy').format(a.data) ==
            DateFormat('dd/MM/yyyy').format(selectedDate);
      }).toList();

      List<String> availableSlots = [];

      // Percorre todos os time slots
      for (String slot in timeSlots) {
        DateTime slotStart = DateFormat("HH:mm").parse(slot);
        DateTime slotEnd = slotStart.add(const Duration(hours: 1));

        // Verifica se o slot está ocupado com base nos agendamentos existentes
        bool isOccupied = agendamentosParaData.any((agendamento) {
          DateTime agendamentoHoraInicio =
              DateFormat("HH:mm").parse(agendamento.hora);
          DateTime agendamentoHoraFim = agendamentoHoraInicio
              .add(Duration(hours: agendamento.servico.duracao ~/ 60));

          // Confirma se o slot atual se sobrepõe a algum agendamento existente
          return (slotStart.isBefore(agendamentoHoraFim) &&
              slotEnd.isAfter(agendamentoHoraInicio));
        });

        // Se não estiver ocupado, adiciona à lista de slots disponíveis
        if (!isOccupied) {
          availableSlots.add(slot);
        }
      }

      return availableSlots;
    } catch (e) {
      print("Erro ao buscar horários disponíveis: $e");
      return [];
    }
  }

  @action
  Future<void> salvarAgendamento(
      Agendamento agendamento, BuildContext context) async {
    try {
      isLoading = true;

      // Busca todos os agendamentos para verificação de conflitos
      final agendamentosExistentes = await firebaseUsecase.fetchAgendamentos(
          paraVerificacaoConflito: true);

      DateTime horaAgendamentoInicio =
          DateFormat("HH:mm").parse(agendamento.hora);
      DateTime horaAgendamentoFim = horaAgendamentoInicio
          .add(Duration(hours: agendamento.servico.duracao ~/ 60));

      bool existeConflito = agendamentosExistentes.any((a) {
        if (a.data.isSameDay(agendamento.data)) {
          DateTime horaExistenteInicio = DateFormat("HH:mm").parse(a.hora);
          DateTime horaExistenteFim =
              horaExistenteInicio.add(Duration(hours: a.servico.duracao ~/ 60));

          // Verifica conflito de horários
          return horaAgendamentoInicio.isBefore(horaExistenteFim) &&
              horaAgendamentoFim.isAfter(horaExistenteInicio);
        }
        return false;
      });

      if (existeConflito) {
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
        isLoading = false;
        return;
      }

      agendamento.id = DateTime.now().millisecondsSinceEpoch.toString();

      // Adiciona os horários ocupados de acordo com a duração do serviço
      agendamento.horariosOcupados
          .add(DateFormat("HH:mm").format(horaAgendamentoInicio));
      if (agendamento.servico.duracao == 120) {
        agendamento.horariosOcupados
            .add('${horaAgendamentoInicio.hour + 1}:00');
      }

      await firebaseUsecase.addAgendamento(
        agendamento,
        agendamento.userId,
        agendamento.petId,
      );

      agendamentos.add(agendamento);
      clearPetFields();

      print(currentUserEmail);
      // Enviar confirmação de agendamento por e-mail
      await sendEmail(
        currentUserEmail,
        agendamento,
      );

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
          ],
        ),
      );
      isLoading = false;
    } catch (e) {
      print("Erro ao salvar agendamento: $e");
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
      isLoading = false;
      rethrow;
    }
  }

  sendEmail(String recipient, Agendamento agendamento) async {
    isLoading = true;
    final String serviceId = dotenv.env['EMAILJS_SERVICE_ID'] ?? '';
    final String templateId = dotenv.env['EMAILJS_TEMPLATE_ID'] ?? '';
    final String publicKey = dotenv.env['EMAILJS_PUBLIC_KEY'] ?? '';
    final String privateKey = dotenv.env['EMAILJS_PRIVATE_KEY'] ?? '';

    if (serviceId.isEmpty ||
        templateId.isEmpty ||
        publicKey.isEmpty ||
        privateKey.isEmpty) {
      print('Erro: Variáveis de ambiente não configuradas corretamente.');
      return;
    }

    String formattedDate = DateFormat('dd/MM/yyyy').format(agendamento.data);
    try {
      await emailjs.send(
        serviceId,
        templateId,
        {
          'to_email': recipient,
          'user_name': agendamento.tutor,
          'agendamento_data': formattedDate,
          'agendamento_hora': agendamento.hora,
          'servico': servico[0].nome,
          'agendamento_petNome': agendamento.petNome,
          // 'message': message,
        },
        emailjs.Options(
          publicKey: publicKey,
          privateKey: privateKey,
          limitRate: const emailjs.LimitRate(
            id: 'app',
            throttle: 10000,
          ),
        ),
      );
      print('E-mail enviado com sucesso para $recipient.');
      isLoading = false;
    } catch (error) {
      print('Erro no envio do e-mail: ${error.toString()}');
      isLoading = false;
    }
  }

  // Função para excluir agendamento
  @action
  Future<void> excluirAgendamento(
      Agendamento agendamento, String motivo) async {
    try {
      isLoading = true;
      await firebaseUsecase.deleteAgendamento(agendamento.id!);

      agendamentos.removeWhere((a) => a.id == agendamento.id);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateAgendamento(
      String agendamentoId, Agendamento agendamento, String motivo) async {
    isLoading = true;
    try {
      await firebaseUsecase.updateAgendamento(
          agendamentoId, agendamento, motivo);
      print('Agendamento atualizado com sucesso.');
    } catch (e) {
      print('Erro ao atualizar agendamento: $e');
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> atualizarStatusRealizado(Agendamento agendamento) async {
    isLoading = true;
    try {
      await firebaseUsecase.atualizarStatusRealizado(agendamento);
      print('Agendamento Realizado com sucesso.');
    } catch (e) {
      print('Erro ao realizar agendamento: $e');
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> searchAgendamentos(String query) async {
    isLoading = true;
    errorMessage = '';

    try {
      // Caso o termo de pesquisa esteja vazio, busca todos os agendamentos.
      if (query.isEmpty) {
        await carregarAgendamentos(); // Função que carrega todos os agendamentos
        return;
      }

      final result = await firebaseUsecase.fetchAgendamentos();

      // Filtra os agendamentos pelo nome do pet ou tipo de serviço
      agendamentos = ObservableList.of(
        result
            .where((agendamento) =>
                agendamento.petNome
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                agendamento.servico.nome
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList(),
      );

      if (agendamentos.isEmpty) {
        errorMessage = 'Nenhum agendamento encontrado para "$query".';
      }
    } catch (e) {
      errorMessage = 'Erro ao buscar agendamentos: $e';
      print(errorMessage);
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

  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      print("Erro ao formatar data: $e");
      return date;
    }
  }
}
