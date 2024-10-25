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
            _buildServicoFormSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildServicoListSection() {
    return Expanded(
      flex: 1,
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
                Observer(
                  builder: (_) {
                    if (controller.isLoading) {
                      return const Center(child: CircularProgressIndicator());
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
                            title: Text(
                              servico.nome,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Preço: R\$ ${servico.preco}',
                                ),
                                Text(
                                  'Duração: ${servico.duracao} min.',
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _confirmarExclusao(context, servico);
                              },
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

  Widget _buildServicoFormSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_box, color: MColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Cadastrar Serviço',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildServiceFormFields(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtomWidget(
                    buttonChild: Text(
                      'Confirmar',
                      style: boldFont(MColors.primaryWhite, 16.0),
                    ),
                    onPressed: () => _confirmarCadastro(context),
                    color: MColors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceFormFields() {
    return Column(
      children: [
        buildTextField(
            'Nome do Serviço:', 'Nome', controller.nomeServicoController),
        const SizedBox(height: 10),
        buildMaskedTextField('Preço:', 'Preço', precoController),
        const SizedBox(height: 10),
        buildTextField('Duração do Serviço:', 'Duração',
            controller.duracaoServicoController,
            isNumber: true),
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
    if (controller.nomeServicoController.text.isEmpty ||
        precoController.numberValue <= 0 ||
        controller.duracaoServicoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    final servico = Servico(
      id: "",
      nome: controller.nomeServicoController.text,
      preco: precoController.numberValue,
      duracao: int.parse(controller.duracaoServicoController.text),
    );

    try {
      await controller.addServico(servico);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Serviço adicionado com sucesso!')),
      );
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
}
