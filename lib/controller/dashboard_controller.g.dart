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

  late final _$cadastrarClienteAsyncAction = AsyncAction(
      '_DashboardControllerBase.cadastrarCliente',
      context: context);

  @override
  Future<void> cadastrarCliente(
      {required BuildContext context, required String sexo}) {
    return _$cadastrarClienteAsyncAction
        .run(() => super.cadastrarCliente(context: context, sexo: sexo));
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

  late final _$searchCepAsyncAction =
      AsyncAction('_DashboardControllerBase.searchCep', context: context);

  @override
  Future<void> searchCep(String cep, BuildContext context) {
    return _$searchCepAsyncAction.run(() => super.searchCep(cep, context));
  }

  late final _$fetchPetsAsyncAction =
      AsyncAction('_DashboardControllerBase.fetchPets', context: context);

  @override
  Future<void> fetchPets() {
    return _$fetchPetsAsyncAction.run(() => super.fetchPets());
  }

  late final _$cadastrarPetAsyncAction =
      AsyncAction('_DashboardControllerBase.cadastrarPet', context: context);

  @override
  Future<void> cadastrarPet(
      {required BuildContext context,
      required String sexo,
      required String tipoPet,
      required String raca,
      required String porte}) {
    return _$cadastrarPetAsyncAction.run(() => super.cadastrarPet(
        context: context,
        sexo: sexo,
        tipoPet: tipoPet,
        raca: raca,
        porte: porte));
  }

  late final _$deletePetAsyncAction =
      AsyncAction('_DashboardControllerBase.deletePet', context: context);

  @override
  Future<void> deletePet(String petId) {
    return _$deletePetAsyncAction.run(() => super.deletePet(petId));
  }

  late final _$_DashboardControllerBaseActionController =
      ActionController(name: '_DashboardControllerBase', context: context);

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
isLoading: ${isLoading},
isLoadingPet: ${isLoadingPet},
errorMessage: ${errorMessage}
    ''';
  }
}
