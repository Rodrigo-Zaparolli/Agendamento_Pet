// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardController on _DashboardControllerBase, Store {
  late final _$sexoSelecionadoAtom =
      Atom(name: '_DashboardControllerBase.sexoSelecionado', context: context);

  @override
  String get sexoSelecionado {
    _$sexoSelecionadoAtom.reportRead();
    return super.sexoSelecionado;
  }

  @override
  set sexoSelecionado(String value) {
    _$sexoSelecionadoAtom.reportWrite(value, super.sexoSelecionado, () {
      super.sexoSelecionado = value;
    });
  }

  late final _$tipoPetSelecionadoAtom = Atom(
      name: '_DashboardControllerBase.tipoPetSelecionado', context: context);

  @override
  String get tipoPetSelecionado {
    _$tipoPetSelecionadoAtom.reportRead();
    return super.tipoPetSelecionado;
  }

  @override
  set tipoPetSelecionado(String value) {
    _$tipoPetSelecionadoAtom.reportWrite(value, super.tipoPetSelecionado, () {
      super.tipoPetSelecionado = value;
    });
  }

  late final _$tipoPorteSelecionadoAtom = Atom(
      name: '_DashboardControllerBase.tipoPorteSelecionado', context: context);

  @override
  String get tipoPorteSelecionado {
    _$tipoPorteSelecionadoAtom.reportRead();
    return super.tipoPorteSelecionado;
  }

  @override
  set tipoPorteSelecionado(String value) {
    _$tipoPorteSelecionadoAtom.reportWrite(value, super.tipoPorteSelecionado,
        () {
      super.tipoPorteSelecionado = value;
    });
  }

  late final _$racaSelecionadaAtom =
      Atom(name: '_DashboardControllerBase.racaSelecionada', context: context);

  @override
  String get racaSelecionada {
    _$racaSelecionadaAtom.reportRead();
    return super.racaSelecionada;
  }

  @override
  set racaSelecionada(String value) {
    _$racaSelecionadaAtom.reportWrite(value, super.racaSelecionada, () {
      super.racaSelecionada = value;
    });
  }

  late final _$porteSelecionadoAtom =
      Atom(name: '_DashboardControllerBase.porteSelecionado', context: context);

  @override
  String get porteSelecionado {
    _$porteSelecionadoAtom.reportRead();
    return super.porteSelecionado;
  }

  @override
  set porteSelecionado(String value) {
    _$porteSelecionadoAtom.reportWrite(value, super.porteSelecionado, () {
      super.porteSelecionado = value;
    });
  }

  late final _$tutorSelecionadoAtom =
      Atom(name: '_DashboardControllerBase.tutorSelecionado', context: context);

  @override
  String get tutorSelecionado {
    _$tutorSelecionadoAtom.reportRead();
    return super.tutorSelecionado;
  }

  @override
  set tutorSelecionado(String value) {
    _$tutorSelecionadoAtom.reportWrite(value, super.tutorSelecionado, () {
      super.tutorSelecionado = value;
    });
  }

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

  late final _$petIdToUpdateAtom =
      Atom(name: '_DashboardControllerBase.petIdToUpdate', context: context);

  @override
  String get petIdToUpdate {
    _$petIdToUpdateAtom.reportRead();
    return super.petIdToUpdate;
  }

  @override
  set petIdToUpdate(String value) {
    _$petIdToUpdateAtom.reportWrite(value, super.petIdToUpdate, () {
      super.petIdToUpdate = value;
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
  ObservableList<Pet> get pets {
    _$petsAtom.reportRead();
    return super.pets;
  }

  @override
  set pets(ObservableList<Pet> value) {
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

  late final _$availableTimeSlotsAtom = Atom(
      name: '_DashboardControllerBase.availableTimeSlots', context: context);

  @override
  List<String> get availableTimeSlots {
    _$availableTimeSlotsAtom.reportRead();
    return super.availableTimeSlots;
  }

  @override
  set availableTimeSlots(List<String> value) {
    _$availableTimeSlotsAtom.reportWrite(value, super.availableTimeSlots, () {
      super.availableTimeSlots = value;
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

  late final _$isLoadingSearchPetAtom = Atom(
      name: '_DashboardControllerBase.isLoadingSearchPet', context: context);

  @override
  bool get isLoadingSearchPet {
    _$isLoadingSearchPetAtom.reportRead();
    return super.isLoadingSearchPet;
  }

  @override
  set isLoadingSearchPet(bool value) {
    _$isLoadingSearchPetAtom.reportWrite(value, super.isLoadingSearchPet, () {
      super.isLoadingSearchPet = value;
    });
  }

  late final _$isTimeSlotEnabledAtom = Atom(
      name: '_DashboardControllerBase.isTimeSlotEnabled', context: context);

  @override
  bool get isTimeSlotEnabled {
    _$isTimeSlotEnabledAtom.reportRead();
    return super.isTimeSlotEnabled;
  }

  @override
  set isTimeSlotEnabled(bool value) {
    _$isTimeSlotEnabledAtom.reportWrite(value, super.isTimeSlotEnabled, () {
      super.isTimeSlotEnabled = value;
    });
  }

  late final _$isUpdateClientAtom =
      Atom(name: '_DashboardControllerBase.isUpdateClient', context: context);

  @override
  bool get isUpdateClient {
    _$isUpdateClientAtom.reportRead();
    return super.isUpdateClient;
  }

  @override
  set isUpdateClient(bool value) {
    _$isUpdateClientAtom.reportWrite(value, super.isUpdateClient, () {
      super.isUpdateClient = value;
    });
  }

  late final _$isUpdatePetAtom =
      Atom(name: '_DashboardControllerBase.isUpdatePet', context: context);

  @override
  bool get isUpdatePet {
    _$isUpdatePetAtom.reportRead();
    return super.isUpdatePet;
  }

  @override
  set isUpdatePet(bool value) {
    _$isUpdatePetAtom.reportWrite(value, super.isUpdatePet, () {
      super.isUpdatePet = value;
    });
  }

  late final _$currentClientUserIdAtom = Atom(
      name: '_DashboardControllerBase.currentClientUserId', context: context);

  @override
  String? get currentClientUserId {
    _$currentClientUserIdAtom.reportRead();
    return super.currentClientUserId;
  }

  @override
  set currentClientUserId(String? value) {
    _$currentClientUserIdAtom.reportWrite(value, super.currentClientUserId, () {
      super.currentClientUserId = value;
    });
  }

  late final _$roleAtom =
      Atom(name: '_DashboardControllerBase.role', context: context);

  @override
  String get role {
    _$roleAtom.reportRead();
    return super.role;
  }

  @override
  set role(String value) {
    _$roleAtom.reportWrite(value, super.role, () {
      super.role = value;
    });
  }

  late final _$currentClientIdAtom =
      Atom(name: '_DashboardControllerBase.currentClientId', context: context);

  @override
  String? get currentClientId {
    _$currentClientIdAtom.reportRead();
    return super.currentClientId;
  }

  @override
  set currentClientId(String? value) {
    _$currentClientIdAtom.reportWrite(value, super.currentClientId, () {
      super.currentClientId = value;
    });
  }

  late final _$racasSelecionadasAtom = Atom(
      name: '_DashboardControllerBase.racasSelecionadas', context: context);

  @override
  List<String> get racasSelecionadas {
    _$racasSelecionadasAtom.reportRead();
    return super.racasSelecionadas;
  }

  @override
  set racasSelecionadas(List<String> value) {
    _$racasSelecionadasAtom.reportWrite(value, super.racasSelecionadas, () {
      super.racasSelecionadas = value;
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

  late final _$selectedTimeSlotAtom =
      Atom(name: '_DashboardControllerBase.selectedTimeSlot', context: context);

  @override
  String? get selectedTimeSlot {
    _$selectedTimeSlotAtom.reportRead();
    return super.selectedTimeSlot;
  }

  @override
  set selectedTimeSlot(String? value) {
    _$selectedTimeSlotAtom.reportWrite(value, super.selectedTimeSlot, () {
      super.selectedTimeSlot = value;
    });
  }

  late final _$agendamentosDiaAtom =
      Atom(name: '_DashboardControllerBase.agendamentosDia', context: context);

  @override
  int get agendamentosDia {
    _$agendamentosDiaAtom.reportRead();
    return super.agendamentosDia;
  }

  @override
  set agendamentosDia(int value) {
    _$agendamentosDiaAtom.reportWrite(value, super.agendamentosDia, () {
      super.agendamentosDia = value;
    });
  }

  late final _$agendamentosMesAtom =
      Atom(name: '_DashboardControllerBase.agendamentosMes', context: context);

  @override
  int get agendamentosMes {
    _$agendamentosMesAtom.reportRead();
    return super.agendamentosMes;
  }

  @override
  set agendamentosMes(int value) {
    _$agendamentosMesAtom.reportWrite(value, super.agendamentosMes, () {
      super.agendamentosMes = value;
    });
  }

  late final _$agendamentosCanceladosMesAtom = Atom(
      name: '_DashboardControllerBase.agendamentosCanceladosMes',
      context: context);

  @override
  int get agendamentosCanceladosMes {
    _$agendamentosCanceladosMesAtom.reportRead();
    return super.agendamentosCanceladosMes;
  }

  @override
  set agendamentosCanceladosMes(int value) {
    _$agendamentosCanceladosMesAtom
        .reportWrite(value, super.agendamentosCanceladosMes, () {
      super.agendamentosCanceladosMes = value;
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

  late final _$deleteClientsAsyncAction =
      AsyncAction('_DashboardControllerBase.deleteClients', context: context);

  @override
  Future<void> deleteClients(Clientes clientes, String userId) {
    return _$deleteClientsAsyncAction
        .run(() => super.deleteClients(clientes, userId));
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

  late final _$deletePetsAsyncAction =
      AsyncAction('_DashboardControllerBase.deletePets', context: context);

  @override
  Future<void> deletePets(Pet pet) {
    return _$deletePetsAsyncAction.run(() => super.deletePets(pet));
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
      required DateTime dataNascimentoPet}) {
    return _$cadastrarPetAsyncAction.run(() => super.cadastrarPet(
        context: context,
        sexo: sexo,
        tipoPet: tipoPet,
        raca: raca,
        porte: porte,
        tutor: tutor,
        dataNascimentoPet: dataNascimentoPet));
  }

  late final _$carregarAgendamentosAsyncAction = AsyncAction(
      '_DashboardControllerBase.carregarAgendamentos',
      context: context);

  @override
  Future<void> carregarAgendamentos() {
    return _$carregarAgendamentosAsyncAction
        .run(() => super.carregarAgendamentos());
  }

  late final _$carregarAgendamentosCanceladosAsyncAction = AsyncAction(
      '_DashboardControllerBase.carregarAgendamentosCancelados',
      context: context);

  @override
  Future<void> carregarAgendamentosCancelados() {
    return _$carregarAgendamentosCanceladosAsyncAction
        .run(() => super.carregarAgendamentosCancelados());
  }

  late final _$getAvailableTimeSlotsAsyncAction = AsyncAction(
      '_DashboardControllerBase.getAvailableTimeSlots',
      context: context);

  @override
  Future<List<String>> getAvailableTimeSlots(DateTime selectedDate) {
    return _$getAvailableTimeSlotsAsyncAction
        .run(() => super.getAvailableTimeSlots(selectedDate));
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
  Future<void> excluirAgendamento(Agendamento agendamento, String motivo) {
    return _$excluirAgendamentoAsyncAction
        .run(() => super.excluirAgendamento(agendamento, motivo));
  }

  late final _$updateAgendamentoAsyncAction = AsyncAction(
      '_DashboardControllerBase.updateAgendamento',
      context: context);

  @override
  Future<void> updateAgendamento(
      String agendamentoId, Agendamento agendamento, String motivo) {
    return _$updateAgendamentoAsyncAction
        .run(() => super.updateAgendamento(agendamentoId, agendamento, motivo));
  }

  late final _$atualizarStatusRealizadoAsyncAction = AsyncAction(
      '_DashboardControllerBase.atualizarStatusRealizado',
      context: context);

  @override
  Future<void> atualizarStatusRealizado(Agendamento agendamento) {
    return _$atualizarStatusRealizadoAsyncAction
        .run(() => super.atualizarStatusRealizado(agendamento));
  }

  late final _$searchAgendamentosAsyncAction = AsyncAction(
      '_DashboardControllerBase.searchAgendamentos',
      context: context);

  @override
  Future<void> searchAgendamentos(String query) {
    return _$searchAgendamentosAsyncAction
        .run(() => super.searchAgendamentos(query));
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

  late final _$updateServicoAsyncAction =
      AsyncAction('_DashboardControllerBase.updateServico', context: context);

  @override
  Future<void> updateServico(String servicoId, Servico servico) {
    return _$updateServicoAsyncAction
        .run(() => super.updateServico(servicoId, servico));
  }

  late final _$searchServicesAsyncAction =
      AsyncAction('_DashboardControllerBase.searchServices', context: context);

  @override
  Future<void> searchServices(String query) {
    return _$searchServicesAsyncAction.run(() => super.searchServices(query));
  }

  late final _$_DashboardControllerBaseActionController =
      ActionController(name: '_DashboardControllerBase', context: context);

  @override
  void setSelectedSexo(String sexo) {
    final _$actionInfo = _$_DashboardControllerBaseActionController.startAction(
        name: '_DashboardControllerBase.setSelectedSexo');
    try {
      return super.setSelectedSexo(sexo);
    } finally {
      _$_DashboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
sexoSelecionado: ${sexoSelecionado},
tipoPetSelecionado: ${tipoPetSelecionado},
tipoPorteSelecionado: ${tipoPorteSelecionado},
racaSelecionada: ${racaSelecionada},
porteSelecionado: ${porteSelecionado},
tutorSelecionado: ${tutorSelecionado},
isAuthenticated: ${isAuthenticated},
petIdToUpdate: ${petIdToUpdate},
clients: ${clients},
pets: ${pets},
agendamentos: ${agendamentos},
servico: ${servico},
availableTimeSlots: ${availableTimeSlots},
isLoading: ${isLoading},
isLoadingPet: ${isLoadingPet},
isLoadingSearchPet: ${isLoadingSearchPet},
isTimeSlotEnabled: ${isTimeSlotEnabled},
isUpdateClient: ${isUpdateClient},
isUpdatePet: ${isUpdatePet},
currentClientUserId: ${currentClientUserId},
role: ${role},
currentClientId: ${currentClientId},
racasSelecionadas: ${racasSelecionadas},
errorMessage: ${errorMessage},
selectedClient: ${selectedClient},
selectedPet: ${selectedPet},
selectedServico: ${selectedServico},
selectedTimeSlot: ${selectedTimeSlot},
agendamentosDia: ${agendamentosDia},
agendamentosMes: ${agendamentosMes},
agendamentosCanceladosMes: ${agendamentosCanceladosMes}
    ''';
  }
}
