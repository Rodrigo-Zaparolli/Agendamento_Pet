// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardController on _DashboardControllerBase, Store {
  late final _$isAuthenticatedAtom =
      Atom(name: '_DashboardControllerBase.isAuthenticated', context: context);

  @override
  bool get isAuthenticated {
    _$isAuthenticatedAtom.reportRead();
    return super.isAuthenticated;
  }

  @override
  set isAuthenticated(bool value) {
    _$isAuthenticatedAtom.reportWrite(value, super.isAuthenticated, () {
      super.isAuthenticated = value;
    });
  }

  late final _$clientsAtom =
      Atom(name: '_DashboardControllerBase.clients', context: context);

  @override
  ObservableList<Clientes> get clients {
    _$clientsAtom.reportRead();
    return super.clients;
  }

  @override
  set clients(ObservableList<Clientes> value) {
    _$clientsAtom.reportWrite(value, super.clients, () {
      super.clients = value;
    });
  }

  late final _$petsAtom =
      Atom(name: '_DashboardControllerBase.pets', context: context);

  @override
  List<Pet> get pets {
    _$petsAtom.reportRead();
    return super.pets;
  }

  @override
  set pets(List<Pet> value) {
    _$petsAtom.reportWrite(value, super.pets, () {
      super.pets = value;
    });
  }

  late final _$agendamentosAtom =
      Atom(name: '_DashboardControllerBase.agendamentos', context: context);

  @override
  ObservableList<Agendamento> get agendamentos {
    _$agendamentosAtom.reportRead();
    return super.agendamentos;
  }

  @override
  set agendamentos(ObservableList<Agendamento> value) {
    _$agendamentosAtom.reportWrite(value, super.agendamentos, () {
      super.agendamentos = value;
    });
  }

  late final _$servicoAtom =
      Atom(name: '_DashboardControllerBase.servico', context: context);

  @override
  List<Servico> get servico {
    _$servicoAtom.reportRead();
    return super.servico;
  }

  @override
  set servico(List<Servico> value) {
    _$servicoAtom.reportWrite(value, super.servico, () {
      super.servico = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_DashboardControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingPetAtom =
      Atom(name: '_DashboardControllerBase.isLoadingPet', context: context);

  @override
  bool get isLoadingPet {
    _$isLoadingPetAtom.reportRead();
    return super.isLoadingPet;
  }

  @override
  set isLoadingPet(bool value) {
    _$isLoadingPetAtom.reportWrite(value, super.isLoadingPet, () {
      super.isLoadingPet = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_DashboardControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$selectedClientAtom =
      Atom(name: '_DashboardControllerBase.selectedClient', context: context);

  @override
  String? get selectedClient {
    _$selectedClientAtom.reportRead();
    return super.selectedClient;
  }

  @override
  set selectedClient(String? value) {
    _$selectedClientAtom.reportWrite(value, super.selectedClient, () {
      super.selectedClient = value;
    });
  }

  late final _$selectedPetAtom =
      Atom(name: '_DashboardControllerBase.selectedPet', context: context);

  @override
  Pet? get selectedPet {
    _$selectedPetAtom.reportRead();
    return super.selectedPet;
  }

  @override
  set selectedPet(Pet? value) {
    _$selectedPetAtom.reportWrite(value, super.selectedPet, () {
      super.selectedPet = value;
    });
  }

  late final _$selectedServicoAtom =
      Atom(name: '_DashboardControllerBase.selectedServico', context: context);

  @override
  Servico? get selectedServico {
    _$selectedServicoAtom.reportRead();
    return super.selectedServico;
  }

  @override
  set selectedServico(Servico? value) {
    _$selectedServicoAtom.reportWrite(value, super.selectedServico, () {
      super.selectedServico = value;
    });
  }

  late final _$cadastrarClienteAsyncAction = AsyncAction(
      '_DashboardControllerBase.cadastrarCliente',
      context: context);

  @override
  Future<void> cadastrarCliente(
      {required BuildContext context,
      required String sexo,
      required DateTime dataNascimento}) {
    return _$cadastrarClienteAsyncAction.run(() => super.cadastrarCliente(
        context: context, sexo: sexo, dataNascimento: dataNascimento));
  }

  late final _$searchClientsAsyncAction =
      AsyncAction('_DashboardControllerBase.searchClients', context: context);

  @override
  Future<void> searchClients(String query) {
    return _$searchClientsAsyncAction.run(() => super.searchClients(query));
  }

  late final _$fetchClientsAsyncAction =
      AsyncAction('_DashboardControllerBase.fetchClients', context: context);

  @override
  Future<void> fetchClients() {
    return _$fetchClientsAsyncAction.run(() => super.fetchClients());
  }

  late final _$searchPetsAsyncAction =
      AsyncAction('_DashboardControllerBase.searchPets', context: context);

  @override
  Future<void> searchPets(String query) {
    return _$searchPetsAsyncAction.run(() => super.searchPets(query));
  }

  late final _$fetchPetsAsyncAction =
      AsyncAction('_DashboardControllerBase.fetchPets', context: context);

  @override
  Future<void> fetchPets() {
    return _$fetchPetsAsyncAction.run(() => super.fetchPets());
  }

  late final _$searchCepAsyncAction =
      AsyncAction('_DashboardControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep(String cep, BuildContext context) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep, context));
  }

  late final _$cadastrarPetAsyncAction =
      AsyncAction('_DashboardControllerBase.cadastrarPet', context: context);

  @override
  Future<void> cadastrarPet(
      {required BuildContext context,
      required String sexo,
      required String tipoPet,
      required String raca,
      required String porte,
      required String tutor,
      required String clienteId}) {
    return _$cadastrarPetAsyncAction.run(() => super.cadastrarPet(
        context: context,
        sexo: sexo,
        tipoPet: tipoPet,
        raca: raca,
        porte: porte,
        tutor: tutor,
        clienteId: clienteId));
  }

  late final _$deletePetAsyncAction =
      AsyncAction('_DashboardControllerBase.deletePet', context: context);

  @override
  Future<void> deletePet(String petId) {
    return _$deletePetAsyncAction.run(() => super.deletePet(petId));
  }

  late final _$carregarAgendamentosAsyncAction = AsyncAction(
      '_DashboardControllerBase.carregarAgendamentos',
      context: context);

  @override
  Future<void> carregarAgendamentos() {
    return _$carregarAgendamentosAsyncAction
        .run(() => super.carregarAgendamentos());
  }

  late final _$verificarDisponibilidadeAsyncAction = AsyncAction(
      '_DashboardControllerBase.verificarDisponibilidade',
      context: context);

  @override
  Future<bool> verificarDisponibilidade(DateTime dataHora) {
    return _$verificarDisponibilidadeAsyncAction
        .run(() => super.verificarDisponibilidade(dataHora));
  }

  late final _$salvarAgendamentoAsyncAction = AsyncAction(
      '_DashboardControllerBase.salvarAgendamento',
      context: context);

  @override
  Future<void> salvarAgendamento(
      Agendamento agendamento, BuildContext context) {
    return _$salvarAgendamentoAsyncAction
        .run(() => super.salvarAgendamento(agendamento, context));
  }

  late final _$excluirAgendamentoAsyncAction = AsyncAction(
      '_DashboardControllerBase.excluirAgendamento',
      context: context);

  @override
  Future<void> excluirAgendamento(Agendamento agendamento) {
    return _$excluirAgendamentoAsyncAction
        .run(() => super.excluirAgendamento(agendamento));
  }

  late final _$fecthServicoAsyncAction =
      AsyncAction('_DashboardControllerBase.fecthServico', context: context);

  @override
  Future<void> fecthServico() {
    return _$fecthServicoAsyncAction.run(() => super.fecthServico());
  }

  late final _$addServicoAsyncAction =
      AsyncAction('_DashboardControllerBase.addServico', context: context);

  @override
  Future<void> addServico(Servico servico) {
    return _$addServicoAsyncAction.run(() => super.addServico(servico));
  }

  late final _$deleteServicoAsyncAction =
      AsyncAction('_DashboardControllerBase.deleteServico', context: context);

  @override
  Future<void> deleteServico(String servicoID) {
    return _$deleteServicoAsyncAction.run(() => super.deleteServico(servicoID));
  }

  late final _$_DashboardControllerBaseActionController =
      ActionController(name: '_DashboardControllerBase', context: context);

  @override
  void setSelectedPet(Pet pet) {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.setSelectedPet');
    try {
      return super.setSelectedPet(pet);
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFields() {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.clearFields');
    try {
      return super.clearFields();
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPetFields() {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.clearPetFields');
    try {
      return super.clearPetFields();
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int calcularIdade(String dataNascimento) {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.calcularIdade');
    try {
      return super.calcularIdade(dataNascimento);
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAuthenticated: ${isAuthenticated},
clients: ${clients},
pets: ${pets},
agendamentos: ${agendamentos},
servico: ${servico},
isLoading: ${isLoading},
isLoadingPet: ${isLoadingPet},
errorMessage: ${errorMessage},
selectedClient: ${selectedClient},
selectedPet: ${selectedPet},
selectedServico: ${selectedServico}
    ''';
  }
}
