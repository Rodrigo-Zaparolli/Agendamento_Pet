// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relatorios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RelatoriosController on _RelatoriosControllerBase, Store {
  late final _$novosClientesAtom =
      Atom(name: '_RelatoriosControllerBase.novosClientes', context: context);

  @override
  int get novosClientes {
    _$novosClientesAtom.reportRead();
    return super.novosClientes;
  }

  @override
  set novosClientes(int value) {
    _$novosClientesAtom.reportWrite(value, super.novosClientes, () {
      super.novosClientes = value;
    });
  }

  late final _$novosPetsAtom =
      Atom(name: '_RelatoriosControllerBase.novosPets', context: context);

  @override
  int get novosPets {
    _$novosPetsAtom.reportRead();
    return super.novosPets;
  }

  @override
  set novosPets(int value) {
    _$novosPetsAtom.reportWrite(value, super.novosPets, () {
      super.novosPets = value;
    });
  }

  late final _$servicosRealizadosAtom = Atom(
      name: '_RelatoriosControllerBase.servicosRealizados', context: context);

  @override
  int get servicosRealizados {
    _$servicosRealizadosAtom.reportRead();
    return super.servicosRealizados;
  }

  @override
  set servicosRealizados(int value) {
    _$servicosRealizadosAtom.reportWrite(value, super.servicosRealizados, () {
      super.servicosRealizados = value;
    });
  }

  late final _$clienteComMaisAgendamentosAtom = Atom(
      name: '_RelatoriosControllerBase.clienteComMaisAgendamentos',
      context: context);

  @override
  String? get clienteComMaisAgendamentos {
    _$clienteComMaisAgendamentosAtom.reportRead();
    return super.clienteComMaisAgendamentos;
  }

  @override
  set clienteComMaisAgendamentos(String? value) {
    _$clienteComMaisAgendamentosAtom
        .reportWrite(value, super.clienteComMaisAgendamentos, () {
      super.clienteComMaisAgendamentos = value;
    });
  }

  late final _$aniversariosClientesAtom = Atom(
      name: '_RelatoriosControllerBase.aniversariosClientes', context: context);

  @override
  ObservableList<Map<String, dynamic>> get aniversariosClientes {
    _$aniversariosClientesAtom.reportRead();
    return super.aniversariosClientes;
  }

  @override
  set aniversariosClientes(ObservableList<Map<String, dynamic>> value) {
    _$aniversariosClientesAtom.reportWrite(value, super.aniversariosClientes,
        () {
      super.aniversariosClientes = value;
    });
  }

  late final _$agendamentosAtom =
      Atom(name: '_RelatoriosControllerBase.agendamentos', context: context);

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

  late final _$agendamentosCanceladosAtom = Atom(
      name: '_RelatoriosControllerBase.agendamentosCancelados',
      context: context);

  @override
  ObservableList<Agendamento> get agendamentosCancelados {
    _$agendamentosCanceladosAtom.reportRead();
    return super.agendamentosCancelados;
  }

  @override
  set agendamentosCancelados(ObservableList<Agendamento> value) {
    _$agendamentosCanceladosAtom
        .reportWrite(value, super.agendamentosCancelados, () {
      super.agendamentosCancelados = value;
    });
  }

  late final _$aniversariosPetsAtom = Atom(
      name: '_RelatoriosControllerBase.aniversariosPets', context: context);

  @override
  ObservableList<Map<String, dynamic>> get aniversariosPets {
    _$aniversariosPetsAtom.reportRead();
    return super.aniversariosPets;
  }

  @override
  set aniversariosPets(ObservableList<Map<String, dynamic>> value) {
    _$aniversariosPetsAtom.reportWrite(value, super.aniversariosPets, () {
      super.aniversariosPets = value;
    });
  }

  late final _$servicosPorTipoAtom =
      Atom(name: '_RelatoriosControllerBase.servicosPorTipo', context: context);

  @override
  Map<String, int> get servicosPorTipo {
    _$servicosPorTipoAtom.reportRead();
    return super.servicosPorTipo;
  }

  @override
  set servicosPorTipo(Map<String, int> value) {
    _$servicosPorTipoAtom.reportWrite(value, super.servicosPorTipo, () {
      super.servicosPorTipo = value;
    });
  }

  late final _$clientesCadastradosAtom = Atom(
      name: '_RelatoriosControllerBase.clientesCadastrados', context: context);

  @override
  ObservableList<Map<String, dynamic>> get clientesCadastrados {
    _$clientesCadastradosAtom.reportRead();
    return super.clientesCadastrados;
  }

  @override
  set clientesCadastrados(ObservableList<Map<String, dynamic>> value) {
    _$clientesCadastradosAtom.reportWrite(value, super.clientesCadastrados, () {
      super.clientesCadastrados = value;
    });
  }

  late final _$petsCadastradosAtom =
      Atom(name: '_RelatoriosControllerBase.petsCadastrados', context: context);

  @override
  ObservableList<Map<String, dynamic>> get petsCadastrados {
    _$petsCadastradosAtom.reportRead();
    return super.petsCadastrados;
  }

  @override
  set petsCadastrados(ObservableList<Map<String, dynamic>> value) {
    _$petsCadastradosAtom.reportWrite(value, super.petsCadastrados, () {
      super.petsCadastrados = value;
    });
  }

  late final _$servicosCadastradosAtom = Atom(
      name: '_RelatoriosControllerBase.servicosCadastrados', context: context);

  @override
  ObservableList<Map<String, dynamic>> get servicosCadastrados {
    _$servicosCadastradosAtom.reportRead();
    return super.servicosCadastrados;
  }

  @override
  set servicosCadastrados(ObservableList<Map<String, dynamic>> value) {
    _$servicosCadastradosAtom.reportWrite(value, super.servicosCadastrados, () {
      super.servicosCadastrados = value;
    });
  }

  late final _$generateReportAsyncAction =
      AsyncAction('_RelatoriosControllerBase.generateReport', context: context);

  @override
  Future<List<Map<String, dynamic>>> generateReport(
      {required String? selectedReport,
      required String? selectedPeriod,
      required void Function() onSuccess,
      required void Function() onError}) {
    return _$generateReportAsyncAction.run(() => super.generateReport(
        selectedReport: selectedReport,
        selectedPeriod: selectedPeriod,
        onSuccess: onSuccess,
        onError: onError));
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_RelatoriosControllerBase.fetchData', context: context);

  @override
  Future<void> fetchData<T>(
      Future<T> Function(DateTime, DateTime) fetchFunction,
      DateTime startDate,
      DateTime endDate,
      void Function(T) updateDataFunction) {
    return _$fetchDataAsyncAction.run(() => super
        .fetchData<T>(fetchFunction, startDate, endDate, updateDataFunction));
  }

  late final _$fetchNovosClientesAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchNovosClientes',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchNovosClientes(
      DateTime inicio, DateTime fim) {
    return _$fetchNovosClientesAsyncAction
        .run(() => super.fetchNovosClientes(inicio, fim));
  }

  late final _$fetchNovosPetsAsyncAction =
      AsyncAction('_RelatoriosControllerBase.fetchNovosPets', context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchNovosPets(
      DateTime inicio, DateTime fim) {
    return _$fetchNovosPetsAsyncAction
        .run(() => super.fetchNovosPets(inicio, fim));
  }

  late final _$fetchServicosRealizadosAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchServicosRealizados',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchServicosRealizados(
      DateTime inicio, DateTime fim) {
    return _$fetchServicosRealizadosAsyncAction
        .run(() => super.fetchServicosRealizados(inicio, fim));
  }

  late final _$fetchAniversariosClientesAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchAniversariosClientes',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchAniversariosClientes(
      DateTime startDate, DateTime endDate) {
    return _$fetchAniversariosClientesAsyncAction
        .run(() => super.fetchAniversariosClientes(startDate, endDate));
  }

  late final _$fetchAniversariosPetsAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchAniversariosPets',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchAniversariosPets(
      DateTime startDate, DateTime endDate) {
    return _$fetchAniversariosPetsAsyncAction
        .run(() => super.fetchAniversariosPets(startDate, endDate));
  }

  late final _$fetchServicosCadastradosAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchServicosCadastrados',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchServicosCadastrados() {
    return _$fetchServicosCadastradosAsyncAction
        .run(() => super.fetchServicosCadastrados());
  }

  late final _$fetchClientesCadastradosAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchClientesCadastrados',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchClientesCadastrados(
      DateTime inicio, DateTime fim) {
    return _$fetchClientesCadastradosAsyncAction
        .run(() => super.fetchClientesCadastrados(inicio, fim));
  }

  late final _$fetchPetsCadastradosAsyncAction = AsyncAction(
      '_RelatoriosControllerBase.fetchPetsCadastrados',
      context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchPetsCadastrados(
      DateTime inicio, DateTime fim) {
    return _$fetchPetsCadastradosAsyncAction
        .run(() => super.fetchPetsCadastrados(inicio, fim));
  }

  @override
  String toString() {
    return '''
novosClientes: ${novosClientes},
novosPets: ${novosPets},
servicosRealizados: ${servicosRealizados},
clienteComMaisAgendamentos: ${clienteComMaisAgendamentos},
aniversariosClientes: ${aniversariosClientes},
agendamentos: ${agendamentos},
agendamentosCancelados: ${agendamentosCancelados},
aniversariosPets: ${aniversariosPets},
servicosPorTipo: ${servicosPorTipo},
clientesCadastrados: ${clientesCadastrados},
petsCadastrados: ${petsCadastrados},
servicosCadastrados: ${servicosCadastrados}
    ''';
  }
}
