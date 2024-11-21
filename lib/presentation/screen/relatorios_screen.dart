// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agendamento_pet/controller/relatorios_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RelatoriosScreen extends StatefulWidget {
  const RelatoriosScreen({super.key});

  @override
  _RelatoriosScreenState createState() => _RelatoriosScreenState();
}

class _RelatoriosScreenState
    extends WidgetStateful<RelatoriosScreen, RelatoriosController> {
  String? selectedReport;
  String? selectedPeriod;
  bool isLoading = false;
  List<Map<String, dynamic>> reportData = [];

  final List<String> reportOptions = [
    'Agendamentos Cancelados',
    'Agendamentos Realizados',
    'Aniversários Clientes',
    'Aniversários Pets',
    'Novos Clientes',
    'Novos Pets',
    'Serviços Cadastrados',
    'Serviços Realizados',
  ];

  final List<String> periodOptions = ['Dia', 'Semana', 'Mês', 'Ano'];

  void _generateReport() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await controller.generateReport(
          selectedReport: selectedReport,
          selectedPeriod: selectedPeriod,
          onSuccess: () {},
          onError: _showErrorMessage);

      setState(() {
        isLoading = false;
        reportData = data;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorMessage();
    }
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao gerar relatório!')),
    );
  }

  // Função para resetar os campos quando uma nova opção for selecionada
  void _resetFields() {
    setState(() {
      selectedPeriod = null;
      reportData = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainerWidget(
        color: MColors.cian,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Dropdown para selecionar o tipo de relatório
                  DropdownButtonFormField<String>(
                    value: selectedReport,
                    items: reportOptions.map((report) {
                      return DropdownMenuItem(
                        value: report,
                        child: Text(report),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReport = value;
                        _resetFields(); // Chama a função para limpar os campos
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Relatório',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Dropdown para selecionar o período
                  DropdownButtonFormField<String>(
                    value: selectedPeriod,
                    items: periodOptions.map((period) {
                      return DropdownMenuItem(
                        value: period,
                        child: Text(period),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPeriod = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Período',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Botão para gerar o relatório
                  CustomButtomWidget(
                    buttonChild: Text(
                      'Gerar Relatório',
                      style: boldFont(MColors.primaryWhite, 16.0),
                    ),
                    onPressed:
                        (selectedReport != null && selectedPeriod != null)
                            ? _generateReport
                            : () {},
                    color: MColors.blue,
                  ),
                  const SizedBox(height: 16),
                  CustomButtomWidget(
                    buttonChild: Text(
                      'Exportar para PDF',
                      style: boldFont(MColors.primaryWhite, 16.0),
                    ),
                    onPressed: reportData.isNotEmpty ? _exportToPdf : () {},
                    color: MColors.blue,
                  ),
                ],
              ),
            ),
            // Exibição do relatório ou carregamento
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: MColors.blue,
                    ))
                  : reportData.isNotEmpty
                      ? _buildReportView()
                      : const Center(
                          child: Text('Selecione um relatório para visualizar'),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir a visualização do relatório com base no tipo selecionado
  Widget _buildReportView() {
    switch (selectedReport) {
      case 'Aniversários Clientes':
        return _buildClientBirthdayReport();
      case 'Aniversários Pets':
        return _buildPetBirthdayReport();
      case 'Novos Clientes':
        return _buildCadastroClienteReport();
      case 'Novos Pets':
        return _buildCadastroPetReport();
      case 'Serviços Cadastrados':
        return _buildServicosCadastradosReport();
      case 'Serviços Realizados':
        return _buildContarServicosRealizadosReport();
      case 'Agendamentos Cancelados':
        return _buildAgendamentosCanceladosReport();
      case 'Agendamentos Realizados':
        return _buildAgendamentosRealizadosReport();

      default:
        return const Center(child: Text('Relatório não implementado'));
    }
  }

  // Relatório de aniversários de clientes
  Widget _buildClientBirthdayReport() {
    return _buildReport(
      reportData,
      ['Nome do Cliente', 'Data de Nascimento', 'Telefone'],
      ['nome', 'nascimento', 'telefone'],
    );
  }

  // Relatório de aniversários de pets
  Widget _buildPetBirthdayReport() {
    return _buildReport(
      reportData,
      ['Nome do Pet', 'Data de Nascimento', 'Idade', 'Tutor'],
      ['nome', 'nascimento', 'idade', 'tutor'],
    );
  }

  //Clientes Novos
  Widget _buildCadastroClienteReport() {
    return _buildReport(
      reportData,
      ['Nome do Cliente', 'Data do cadastro'],
      ['nome', 'dtCadastro'],
    );
  }
  //Pets Novos
  Widget _buildCadastroPetReport() {
    return _buildReport(
      reportData,
      ['Nome do Pet', 'Data do cadastro', 'Tutor'],
      ['nome', 'dtCadastro', 'tutor'],
    );
  }

  Widget _buildServicosCadastradosReport() {
    return _buildReport(
      reportData,
      ['Nome do Servico', 'Pet', 'Porte', 'Duração'],
      ['nome', 'tipo', 'porte', 'duracao'],
    );
  }

  Widget _buildContarServicosRealizadosReport() {
    return _buildReport(
      reportData,
      ['Nome do Serviço', 'Quantidade'],
      ['servico', 'quantidade'],
    );
  }

  Widget _buildAgendamentosCanceladosReport() {
    return _buildReport(
      reportData,
      ['Data Agendamento', 'Data Cancelamento', 'Nome Pet', 'Tutor', 'Motivo Cancel.'],
      ['data', 'cancelledAt', 'petNome', 'tutor', 'motivoCancel'],
    );
  }

  Widget _buildAgendamentosRealizadosReport() {
    // Ajustar os dados para incluir o nome do serviço no campo esperado
    final adjustedReportData = reportData.map((agendamento) {
      return {
        ...agendamento,
        'servico': agendamento['servico']?['nome'] ?? 'Não informado',
      };
    }).toList();

    return _buildReport(
      adjustedReportData,
      ['Data Agendamento', 'Nome Pet', 'Tutor', 'Horário', 'Serviço'],
      ['data', 'petNome', 'tutor', 'hora', 'servico'],
    );
  }

  Widget _buildReport(List<Map<String, dynamic>> reportData,
      List<String> columns, List<String> dataKeys) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: columns
            .map((col) => DataColumn(
                  label: Text(
                    col,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ))
            .toList(),
        rows: reportData.map((item) {
          return DataRow(
            cells: dataKeys.map((key) {
              final value = item[key];
              String displayValue = value?.toString() ?? 'N/A';

              if (key == 'cancelledAt' || key == 'data' && value is Timestamp) {
                displayValue =
                    DateFormat('dd/MM/yyyy').format((value).toDate());
              } else if ((key == 'nascimento' || key == 'dtCadastro') &&
                  value is String) {
                try {
                  final date = DateTime.parse(value);
                  displayValue = DateFormat('dd/MM/yyyy').format(date);
                } catch (e) {
                  displayValue = 'Data inválida';
                }
              } else if ((key == 'nascimento' || key == 'dtCadastro') &&
                  value is Timestamp) {
                displayValue =
                    DateFormat('dd/MM/yyyy').format((value).toDate());
              }

              return DataCell(Text(displayValue));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> _getReportHeaders() {
    switch (selectedReport) {
      case 'Aniversários Clientes':
        return ['Nome do Cliente', 'Data de Nascimento', 'Telefone'];
      case 'Aniversários Pets':
        return ['Nome do Pet', 'Data de Nascimento', 'Idade', 'Tutor'];
      case 'Novos Clientes':
        return ['Nome do Cliente', 'Data do Cadastro'];
      case 'Novos Pets':
        return ['Nome do Pet', 'Data do Cadastro'];
      case 'Serviços Cadastrados':
        return ['Nome do Serviço', 'Pet', 'Porte', 'Duração'];
      case 'Serviços Realizados':
        return ['Nome do Serviço', 'Quantidade'];
      case 'Agendamentos Cancelados':
        return [
          'Data Agendamento',
          'Data Cancelamento',
          'Nome do Pet',
          'Nome do Tutor',
          'Motivo Cancelamento'
        ];
      case 'Agendamentos Realizados':
        return ['Data Agendamento', 'Nome Pet', 'Tutor', 'Horário', 'Serviço'];
      default:
        return [];
    }
  }

  List<String> _getReportData(Map<String, dynamic> row) {
    switch (selectedReport) {
      case 'Aniversários Clientes':
        return [
          row['nome'] ?? 'N/A',
          row['nascimento'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['nascimento'] as Timestamp).toDate())
              : 'N/A',
          row['telefone'] ?? 'N/A',
        ];
      case 'Aniversários Pets':
        return [
          row['nome'] ?? 'N/A',
          row['nascimento'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['nascimento'] as Timestamp).toDate())
              : 'N/A',
          row['idade']?.toString() ?? 'N/A',
          row['tutor'] ?? 'N/A',
        ];
      case 'Novos Clientes':
        return [
          row['nome'] ?? 'N/A',
          row['dtCadastro'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['dtCadastro'] as Timestamp).toDate())
              : 'N/A',
        ];
        // Novos Pets
        case 'Novos Pets':
        return [
          row['nome'] ?? 'N/A',
          row['dtCadastro'] != null
            ? DateFormat('dd/MM/yyyy')
               .format((row['dtCadastro'] as Timestamp).toDate())
            : 'N/A',
        ];

      case 'Serviços Cadastrados':
        return [
          row['nome'] ?? 'N/A',
          row['tipo'] ?? 'N/A',
          row['porte'] ?? 'N/A',
          (row['duracao']?.toString() ?? 'N/A'),
        ];
      case 'Serviços Realizados':
        return [
          row['servico'] ?? 'N/A',
          (row['quantidade']?.toString() ?? 'N/A'),
        ];
      case 'Agendamentos Cancelados':
        return [
          row['data'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['data'] as Timestamp).toDate())
              : 'N/A',
          row['cancelledAt'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['cancelledAt'] as Timestamp).toDate())
              : 'N/A',
          row['petNome'] ?? 'N/A',
          row['tutor'] ?? 'N/A',
          row['motivoCancel'] ?? 'N/A',
        ];
      case 'Agendamentos Realizados':
        return [
          row['data'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format((row['data'] as Timestamp).toDate())
              : 'N/A',
          row['petNome'] ?? 'N/A',
          row['hora'] ?? 'N/A',
          row['servico']?['nome'] ?? 'Não informado',
        ];
      default:
        return [];
    }
  }

 void _exportToPdf() async {
  try {
    final pdf = pw.Document();

    // Adiciona o conteúdo do PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,  // Define o formato A4 em paisagem
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Relatório: $selectedReport',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: _getReportHeaders(),
                data: reportData.map((row) {
                  return _getReportData(row);
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    // Salvar ou baixar o PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    // Exibir mensagem de sucesso para o usuário
    // Você pode substituir isso por um diálogo, notificação ou outra forma de feedback
    print("O PDF foi exportado com sucesso.");
  } catch (e) {
    // Tratamento de erro
    // Aqui você pode exibir uma mensagem de erro ao usuário, logar o erro, etc.
    print("Ocorreu um erro ao exportar o PDF: $e");
  }
}
    }