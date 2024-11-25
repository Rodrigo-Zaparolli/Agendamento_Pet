// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:agendamento_pet/controller/dashboard_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';

class ServicosScreen extends StatefulWidget {
  const ServicosScreen({super.key});

  @override
  State<ServicosScreen> createState() => _ServicosScreenState();
}

class _ServicosScreenState
    extends WidgetStateful<ServicosScreen, DashboardController> {
  final MoneyMaskedTextController precoController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
  );
  @override
  void initState() {
    controller.fecthServico();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainerWidget(
        color: MColors.cian,
        child: Row(
          children: [
            _buildServicoListSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MColors.blue,
        onPressed: () => _showCadastroDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  _showCadastroDialog() {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            "Cadastro de Servico",
            style: boldFont(Colors.black, 20.0),
          ),
          content: Observer(
            builder: (_) => SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.7,
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: [
                    _buildPetTypeAndSizeFields(),
                    const SizedBox(height: 20),
                    buildTextField('Nome do Serviço:', 'Nome',
                        controller.nomeServicoController),
                    const SizedBox(height: 10),
                    buildMaskedTextField('Preço:', 'Preço', precoController),
                    const SizedBox(height: 10),
                    buildTextField('Duração do Serviço:', 'Duração',
                        controller.duracaoServicoController,
                        isNumber: true),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtomWidget(
                        buttonChild: Text(
                          'Confirmar',
                          style: boldFont(MColors.primaryWhite, 16.0),
                        ),
                        onPressed: () async {
                          await _confirmarCadastro(context);
                          Navigator.of(context).pop();
                        },
                        color: MColors.blue,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPetTypeAndSizeFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildDropdownField(
            'Tipo de Pet:',
            ['Escolha', 'Cão', 'Gato'],
            value: controller.tipoPetSelecionado,
            onChanged: (value) {
              controller.tipoPetSelecionado = value ?? 'Escolha';
              controller.porteSelecionado = 'Escolha';
              controller.racasSelecionadas = [];
              controller.racaSelecionada = 'Escolha';
            },
            validator: (value) {
              if (value == null || value == 'Escolha') {
                return 'Por favor, selecione o tipo de pet';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
            'Porte:',
            controller.tipoPetSelecionado == 'Escolha'
                ? ['Escolha']
                : controller.porte[controller.tipoPetSelecionado] ??
                    ['Escolha'],
            value: controller.porteSelecionado,
            onChanged: (value) {
              controller.porteSelecionado = value ?? 'Escolha';
              controller.racaSelecionada = 'Escolha';

              controller.atualizarRacas();
            },
            validator: (value) {
              if (value == null || value == 'Escolha') {
                return 'Por favor, selecione o porte';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServicoListSection() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.list, color: MColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Serviços',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar Serviço',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    controller.searchServices(value);
                  },
                ),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: MColors.blue),
                      );
                    }

                    if (controller.servico.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum serviço encontrado.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.servico.length,
                        itemBuilder: (context, index) {
                          final servico = controller.servico[index];
                          return ListTile(
                            title: Text(servico.nome),
                            subtitle: Text('Preço: R\$ ${servico.preco} / '
                                'Duração: ${servico.duracao} minutos'
                                'Tipo: ${servico.tipo} / '
                                'Porte: ${servico.porte} '),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _showEditDialog(context, servico);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _confirmarExclusao(context, servico);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(
    String label,
    List<String> options, {
    String? value,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
  }) {
    // Verifica se o valor inicial existe na lista de opções.
    final initialValue = options.contains(value)
        ? value
        : (options.isNotEmpty ? options.first : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: initialValue,
          items: options
              .toSet() // Remove valores duplicados
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  // Função específica para campos de texto com máscara
  Widget buildMaskedTextField(
      String label, String hint, MoneyMaskedTextController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmarCadastro(BuildContext context) async {
    if (controller.tipoPetSelecionado.isEmpty ||
        controller.porteSelecionado.isEmpty ||
        controller.nomeServicoController.text.isEmpty ||
        precoController.numberValue <= 0 ||
        controller.duracaoServicoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    final servico = Servico(
      id: "",
      tipo: controller.tipoPetSelecionado,
      porte: controller.porteSelecionado,
      nome: controller.nomeServicoController.text,
      preco: precoController.numberValue,
      duracao: int.parse(controller.duracaoServicoController.text),
    );

    try {
      await controller.addServico(servico);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Serviço adicionado com sucesso!')),
      );
      controller.tipoServicoController.clear();
      controller.porteServicoController.clear();
      controller.nomeServicoController.clear();
      precoController.clear();
      controller.duracaoServicoController.clear();
      await controller.fecthServico();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar serviço: $e')),
      );
    }
  }

  void _confirmarExclusao(BuildContext context, Servico servico) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Serviço'),
          content:
              Text('Tem certeza que deseja excluir o serviço ${servico.nome}?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                Navigator.of(context).pop();
                await controller.deleteServico(servico.id);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Servico servico) {
    final TextEditingController tipoController =
        TextEditingController(text: servico.tipo);
    final TextEditingController porteController =
        TextEditingController(text: servico.porte);
    final TextEditingController nomeController =
        TextEditingController(text: servico.nome);
    final TextEditingController precoController =
        TextEditingController(text: servico.preco.toString());
    final TextEditingController duracaoController =
        TextEditingController(text: servico.duracao.toString());

    //Editar o serviço
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Serviço'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tipoController,
                decoration: const InputDecoration(labelText: 'Escolha o tipo'),
              ),
              TextField(
                controller: porteController,
                decoration:
                    const InputDecoration(labelText: 'Escolha o porte do Pet'),
              ),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Serviço'),
              ),
              TextField(
                controller: precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: duracaoController,
                decoration: const InputDecoration(labelText: 'Duração (min)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                servico.nome = nomeController.text;
                servico.preco =
                    double.tryParse(precoController.text) ?? servico.preco;
                servico.duracao =
                    int.tryParse(duracaoController.text) ?? servico.duracao;

                controller.updateServico(servico.id, servico);

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
