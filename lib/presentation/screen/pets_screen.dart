import 'package:agendamento_pet/controller/dashboard_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends WidgetStateful<PetsScreen, DashboardController> {
  final _formKey = GlobalKey<FormState>();

  String sexoSelecionado = 'Escolha';
  String tipoPetSelecionado = 'Escolha';
  String tipoPorteSelecionado = 'Escolha';
  String racaSelecionada = 'Escolha';
  String porteSelecionado = 'Escolha';
  String tutorSelecionado = 'Escolha';
  DateTime? dataNascimento;

  List<String> racasSelecionadas = [];

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

  void calcularIdade(String? data) {
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
        controller.idadePetController.text = 'menos de um mês';
      } else if (idadeAnos == 0) {
        controller.idadePetController.text = '${totalMeses} meses';
      } else {
        controller.idadePetController.text =
            '$idadeAnos anos e $idadeMeses meses';
      }

      double idadeDecimal = totalMeses / 12.0;
      controller.idadeDecimalPetController.text =
          idadeDecimal.toStringAsFixed(1);
    } else {
      controller.idadePetController.clear();
      controller.idadeDecimalPetController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomContainerWidget(
          color: MColors.cian,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildTextField(
                                      'Nome:',
                                      'Nome do pet',
                                      controller.nomePetController,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Por favor, insira o nome do pet';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: buildDropdownField(
                                      'Sexo:',
                                      ['Escolha', 'Macho', 'Fêmea'],
                                      onChanged: (value) {
                                        setState(() {
                                          sexoSelecionado = value ?? 'Escolha';
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value == 'Escolha') {
                                          return 'Por favor, selecione o sexo';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
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
                                          tipoPetSelecionado =
                                              value ?? 'Escolha';
                                          porteSelecionado = 'Escolha';
                                          racasSelecionadas = [];
                                          racaSelecionada = 'Escolha';
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value == 'Escolha') {
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
                                      tipoPetSelecionado == 'Escolha'
                                          ? ['Escolha']
                                          : porte[tipoPetSelecionado] ??
                                              ['Escolha'],
                                      onChanged: (value) {
                                        setState(() {
                                          porteSelecionado = value ?? 'Escolha';
                                          racasSelecionadas = [];
                                          racaSelecionada = 'Escolha';

                                          if (tipoPetSelecionado == 'Cão') {
                                            if (porteSelecionado == 'Pequeno') {
                                              racasSelecionadas =
                                                  portePequeno['Cão'] ?? [];
                                            } else if (porteSelecionado ==
                                                'Médio') {
                                              racasSelecionadas =
                                                  porteMedio['Cão'] ?? [];
                                            } else if (porteSelecionado ==
                                                'Grande') {
                                              racasSelecionadas =
                                                  porteGrande['Cão'] ?? [];
                                            }
                                          } else if (tipoPetSelecionado ==
                                              'Gato') {
                                            if (porteSelecionado ==
                                                'Pequeno, de 2 a 4 kg') {
                                              racasSelecionadas =
                                                  portePequeno['Gato'] ?? [];
                                            } else if (porteSelecionado ==
                                                'Médio, de 4 a 6 kg') {
                                              racasSelecionadas =
                                                  porteMedio['Gato'] ?? [];
                                            } else if (porteSelecionado ==
                                                'Grande, acima de 6 kg') {
                                              racasSelecionadas =
                                                  porteGrande['Gato'] ?? [];
                                            }
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value == 'Escolha') {
                                          return 'Por favor, selecione o porte';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: buildDropdownField(
                                      'Raça:',
                                      racasSelecionadas.isEmpty
                                          ? ['Escolha']
                                          : racasSelecionadas,
                                      onChanged: (value) {
                                        setState(() {
                                          racaSelecionada = value ?? 'Escolha';
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value == 'Escolha') {
                                          return 'Por favor, selecione a raça';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildTextField(
                                      'Nascimento:',
                                      'Data de Nascimento',
                                      controller.nascimentoPetController,
                                      keyboardType: TextInputType.datetime,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Por favor, insira a data de nascimento';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        calcularIdade(value);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.calendar_today,
                                      size: 40,
                                    ),
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            dataNascimento ?? DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null &&
                                          picked != dataNascimento) {
                                        setState(() {
                                          dataNascimento = picked;
                                          controller.nascimentoPetController
                                                  .text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(dataNascimento!);
                                          calcularIdade(controller
                                              .nascimentoPetController.text);
                                        });
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: buildTextField(
                                      'Idade (decimal):',
                                      'Idade do Pet (ex: 0,3)',
                                      controller.idadeDecimalPetController,
                                      keyboardType: TextInputType.number,
                                      readOnly:
                                          true, // Para que o usuário não possa editar
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: buildTextField(
                                      'Peso:',
                                      'Peso do pet (kg)',
                                      controller.pesoPetController,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Por favor, insira o peso';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: buildTextField(
                                    'Tutor:',
                                    'Nome do tutor',
                                    controller.tutorController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Por favor, insira o nome do tutor';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                              const SizedBox(height: 32),
                              // Botão de Confirmação
                              Center(
                                child: SizedBox(
                                  width: 200,
                                  child: CustomButtomWidget(
                                    buttonChild: Text(
                                      'Confirmar Cadastro',
                                      style: boldFont(
                                        MColors.primaryWhite,
                                        16.0,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        await controller.cadastrarPet(
                                          context: context,
                                          sexo: sexoSelecionado,
                                          tipoPet: tipoPetSelecionado,
                                          porte: porteSelecionado,
                                          raca: racaSelecionada,
                                          tutor: tutorSelecionado,
                                        );
                                        controller.clearFields();
                                      }
                                    },
                                    color: MColors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/petshop.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged, // Adiciona o onChanged para o cálculo da idade
          readOnly: readOnly, // Define se o campo é somente leitura
        ),
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
}
