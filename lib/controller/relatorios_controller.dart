import 'package:agendamento_pet/domain/model/agendamento.dart';
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
part 'relatorios_controller.g.dart';

@injectable
class RelatoriosController = _RelatoriosControllerBase
    with _$RelatoriosController;

abstract class _RelatoriosControllerBase with Store {
  final FirebaseUsecase firebaseUsecase;

  _RelatoriosControllerBase(this.firebaseUsecase);

  // Stores to hold the data for the reports
  @observable
  int novosClientes = 0;

  @observable
  int servicosRealizados = 0;

  @observable
  String? clienteComMaisAgendamentos;

  @observable
  ObservableList<Map<String, dynamic>> aniversariosClientes =
      ObservableList.of([]);

  @observable
  ObservableList<Agendamento> agendamentos = ObservableList<Agendamento>();

  @observable
  ObservableList<Agendamento> agendamentosCancelados =
      ObservableList<Agendamento>();

  @observable
  ObservableList<Map<String, dynamic>> aniversariosPets = ObservableList.of([]);

  @observable
  Map<String, int> servicosPorTipo = {};

  @observable
  ObservableList<Map<String, dynamic>> clientesCadastrados =
      ObservableList.of([]);

  @observable
  ObservableList<Map<String, dynamic>> servicosCadastrados =
      ObservableList.of([]);

  // Método para gerar o relatório
  @action
  Future<List<Map<String, dynamic>>> generateReport({
    required String? selectedReport,
    required String? selectedPeriod,
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    // Your logic to generate the report data
    try {
      // Fetch report data based on selectedReport and selectedPeriod
      List<Map<String, dynamic>> data =
          await _generateSpecificReport(selectedReport!, selectedPeriod!);

      // Call onSuccess if the report is generated successfully
      onSuccess();
      return data;
    } catch (e) {
      // Handle error and call onError
      onError();
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _generateSpecificReport(
      String reportType, String period) async {
    DateTime startDate;
    DateTime endDate;

    // Configurando o intervalo de datas com base no período selecionado
    if (period == 'Dia') {
      startDate = DateTime.now();
      endDate = DateTime.now();
    } else if (period == 'Semana') {
      int dayOfWeek = DateTime.now().weekday;
      startDate = DateTime.now().subtract(Duration(days: dayOfWeek - 1));
      endDate = startDate.add(const Duration(days: 6));
    } else if (period == 'Mês') {
      int year = DateTime.now().year;
      int month = DateTime.now().month;
      startDate = DateTime(year, month, 1);
      endDate = DateTime(year, month + 1, 0);
    } else if (period == 'Ano') {
      int year = DateTime.now().year;
      startDate = DateTime(year, 1, 1);
      endDate = DateTime(year, 12, 31);
    } else {
      throw Exception('Período desconhecido');
    }

    List<Map<String, dynamic>> reportData = [];

    // Selecionando a função apropriada com base no tipo de relatório
    switch (reportType) {
      case 'Novos Clientes':
        reportData = await fetchNovosClientes(startDate, endDate);
        break;
      case 'Aniversários Clientes':
        reportData = await fetchAniversariosClientes(startDate, endDate);
        break;
      case 'Aniversários Pet':
        reportData = await fetchAniversariosPets(startDate, endDate);
        break;
      case 'Clientes Cadastrados':
        reportData = await fetchClientesCadastrados(startDate, endDate);
        break;
      case 'Serviços Cadastrados':
        reportData = await fetchServicosCadastrados();
        break;
      case 'Serviços Realizados':
        reportData = await fetchServicosRealizados(startDate, endDate);
        break;
      case 'Agendamentos Cancelados':
        reportData = await fetchAgendamentosCancelados(startDate, endDate);
        break;
      case 'Agendamentos Realizados':
        reportData = await fetchAgendamentosRealizados(startDate, endDate);
        break;
      default:
        throw Exception('Relatório desconhecido');
    }

    return reportData;
  }

  // Função genérica para buscar dados
  @action
  Future<void> fetchData<T>(
    Future<T> Function(DateTime, DateTime) fetchFunction,
    DateTime startDate,
    DateTime endDate,
    void Function(T) updateDataFunction,
  ) async {
    try {
      final result = await fetchFunction(startDate, endDate);
      updateDataFunction(result);
    } catch (e) {
      print("Erro ao buscar dados: $e");
    }
  }

// Funções específicas para buscar dados de relatórios - agora retornando os dados
  @action
  Future<List<Map<String, dynamic>>> fetchNovosClientes(
      DateTime inicio, DateTime fim) async {
    try {
      return await firebaseUsecase.listarNovosClientes(inicio, fim);
    } catch (e) {
      print("Erro ao buscar novos clientes: $e");
      return [];
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchServicosRealizados(
      DateTime inicio, DateTime fim) async {
    try {
      // Chama a função no firebaseUsecase que retorna a lista de serviços realizados
      List<Map<String, dynamic>> servicos =
          await firebaseUsecase.contarServicosRealizados(inicio, fim);

      // Retorna a lista de serviços
      return servicos;
    } catch (e) {
      print("Erro ao buscar serviços realizados: $e");
      // Caso ocorra um erro, retorna uma lista vazia
      return [];
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchAniversariosClientes(
      DateTime startDate, DateTime endDate) async {
    try {
      return await firebaseUsecase.aniversariosClientes(startDate, endDate);
    } catch (e) {
      print("Erro ao buscar aniversários de clientes: $e");
      return [];
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchAniversariosPets(
      DateTime startDate, DateTime endDate) async {
    try {
      return await firebaseUsecase.aniversariosPets(startDate, endDate);
    } catch (e) {
      print("Erro ao buscar aniversários de pets: $e");
      return [];
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchServicosCadastrados() async {
    try {
      return await firebaseUsecase.fetchServicosCadastrados();
    } catch (e) {
      print("Erro ao buscar serviços por tipo: $e");
      return [];
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchClientesCadastrados(
      DateTime inicio, DateTime fim) async {
    try {
      return await firebaseUsecase.fetchClientesCadastrados(inicio, fim);
    } catch (e) {
      print("Erro ao buscar clientes cadastrados: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchAgendamentosCancelados(
      DateTime startDate, DateTime endDate) async {
    List<Agendamento> agendamentos =
        await firebaseUsecase.listarAgendamentosCancelados(startDate, endDate);

    // Converte cada Agendamento em Map<String, dynamic>
    List<Map<String, dynamic>> agendamentosMap =
        agendamentos.map((agendamento) => agendamento.toJson()).toList();

    return agendamentosMap;
  }

  Future<List<Map<String, dynamic>>> fetchAgendamentosRealizados(
      DateTime startDate, DateTime endDate) async {
    List<Agendamento> agendamentos =
        await firebaseUsecase.listarAgendamentosRealizados(startDate, endDate);

    // Converte cada Agendamento em Map<String, dynamic>
    List<Map<String, dynamic>> agendamentosMap =
        agendamentos.map((agendamento) => agendamento.toJson()).toList();

    return agendamentosMap;
  }

  // Formatação da data
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
