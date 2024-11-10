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

  List<String> racasSelecionadas = [];
  String tipoPetSelecionado = 'Escolha';
  String tipoPorteSelecionado = 'Escolha';
  String racaSelecionada = 'Escolha';
  String porteSelecionado = 'Escolha';

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
                            title: Text(
                              servico.nome,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Preço: R\$ ${servico.preco}'),
                                Text('Duração: ${servico.duracao} min.'),
                                Text(
                                    'Tipo: ${servico.tipo}'), // Exibe o tipo do serviço
                                Text(
                                    'Porte: ${servico.porte}'), // Exibe o porte do serviço
                              ],
                            ),
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
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: buildDropdownField(
                'Tipo de Pet:',
                ['Escolha', 'Cão', 'Gato'],
                onChanged: (value) {
                  setState(() {
                    tipoPetSelecionado = value ?? 'Escolha';
                    porteSelecionado = 'Escolha';
                    racasSelecionadas = [];
                    racaSelecionada = 'Escolha';
                  });
                },
                validator: (value) {
                  if (value == null || value == 'Escolha') {
                    return 'Por favor, selecione o tipo de pet';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: buildDropdownField(
                'Porte:',
                tipoPetSelecionado == 'Escolha'
                    ? ['Escolha']
                    : porte[tipoPetSelecionado] ?? ['Escolha'],
                onChanged: (value) {
                  setState(() {
                    porteSelecionado = value ?? 'Escolha';
                    racasSelecionadas = [];
                    racaSelecionada = 'Escolha';

                    if (tipoPetSelecionado == 'Cão') {
                      if (porteSelecionado == 'Pequeno') {
                        racasSelecionadas = portePequeno['Cão'] ?? [];
                      } else if (porteSelecionado == 'Médio') {
                        racasSelecionadas = porteMedio['Cão'] ?? [];
                      } else if (porteSelecionado == 'Grande') {
                        racasSelecionadas = porteGrande['Cão'] ?? [];
                      }
                    } else if (tipoPetSelecionado == 'Gato') {
                      if (porteSelecionado == 'Pequeno, de 2 a 4 kg') {
                        racasSelecionadas = portePequeno['Gato'] ?? [];
                      } else if (porteSelecionado == 'Médio, de 4 a 6 kg') {
                        racasSelecionadas = porteMedio['Gato'] ?? [];
                      } else if (porteSelecionado == 'Grande, acima de 6 kg') {
                        racasSelecionadas = porteGrande['Gato'] ?? [];
                      }
                    }
                  });
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
        ),
        const SizedBox(height: 20),
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

  Widget buildDropdownField(
    String label,
    List<String> options, {
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: options.contains('Escolha') ? 'Escolha' : null,
          items: options
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
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
    if (tipoPetSelecionado.isEmpty ||
        porteSelecionado.isEmpty ||
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
      tipo: tipoPetSelecionado,
      porte: porteSelecionado,
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
