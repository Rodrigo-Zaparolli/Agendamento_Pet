import 'package:agendamento_pet/controller/dashboard_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends WidgetStateful<PetsScreen, DashboardController> {
  DateTime? dataNascimento;

  @override
  void initState() {
    super.initState();

    controller.fetchClients();
    controller.fetchPets();
  }

  List<String> tutores = [];

  final _formKey = GlobalKey<FormState>();

  List<String> racasSelecionadas = [];

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
        controller.idadePetController.text = '$totalMeses meses';
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
        child: Observer(
          builder: (_) => CustomContainerWidget(
            color: MColors.cian,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  _buildPetsListSection(),
                  Expanded(
                    flex: 2,
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
                                _buildTutorAndPetNameFields(),
                                const SizedBox(height: 16),
                                _buildPetTypeAndSizeFields(),
                                const SizedBox(height: 16),
                                _buildBirthDateAndAgeFields(),
                                const SizedBox(height: 16),
                                _buildWeightField(),
                                const SizedBox(height: 32),
                                _buildConfirmationButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTutorAndPetNameFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Observer(
            builder: (_) {
              return buildDropdownField(
                'Tutor:',
                controller.clients.isEmpty
                    ? ["Escolha"]
                    : controller.clients.map((client) => client.nome).toList(),
                value: controller.tutorSelecionado,
                onChanged: (value) {
                  controller.tutorSelecionado = value ?? 'Escolha';
                },
                validator: (value) {
                  if (value == null || value == 'Escolha') {
                    return 'Por favor, selecione o tutor';
                  }
                  return null;
                },
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildTextField(
            'Nome:',
            'Nome do pet',
            controller.nomePetController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
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
            value: controller.sexoSelecionado,
            onChanged: (value) {
              controller.sexoSelecionado = value ?? 'Escolha';
            },
            validator: (value) {
              if (value == null || value == 'Escolha') {
                return 'Por favor, selecione o sexo';
              }
              return null;
            },
          ),
        ),
      ],
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
              racasSelecionadas = []; // Limpar raças ao mudar o tipo
              controller.racaSelecionada = 'Escolha'; // Resetar a raça
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
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
            'Raça:',
            controller.racasSelecionadas.isEmpty
                ? ['Escolha']
                : controller.racasSelecionadas,
            value: controller.racaSelecionada,
            onChanged: (value) {
              controller.racaSelecionada = value ?? 'Escolha';
            },
            validator: (value) {
              if (value == null || value == 'Escolha') {
                return 'Por favor, selecione a raça';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBirthDateAndAgeFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildDateField(
            'Nascimento:',
            'Data de Nascimento',
            onDateSelected: (date) {
              controller.nascimentoPetController.text =
                  "${date.day}/${date.month}/${date.year}";
            },
            validator: (value) {
              if (controller.nascimentoPetController.text.isEmpty) {
                return 'Por favor, selecione a data de nascimento';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: buildTextField(
            'Idade (decimal):',
            'Idade do Pet (ex: 0,3)',
            controller.idadeDecimalPetController,
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildWeightField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildTextField(
            'Peso:',
            'Peso do pet (kg)',
            controller.pesoPetController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Por favor, insira o peso';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationButton() {
    return Center(
      child: SizedBox(
        width: 200,
        child: CustomButtomWidget(
          buttonChild: Text(
            controller.isUpdatePet ? 'Atualizar Pet' : 'Confirmar Cadastro',
            style: boldFont(MColors.primaryWhite, 16.0),
          ),
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              await controller.cadastrarPet(
                context: context,
                sexo: controller.sexoSelecionado,
                tipoPet: controller.tipoPetSelecionado,
                porte: controller.porteSelecionado,
                raca: controller.racaSelecionada,
                tutor: controller.tutorSelecionado,
              );
              controller.clearFields();
            }
          },
          color: MColors.blue,
        ),
      ),
    );
  }

  Widget _buildPetsListSection() {
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
                    Icon(Icons.calendar_today, color: MColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Pets',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Pesquisar Pets',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => controller.searchPets(value),
                ),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    if (controller.isLoadingSearchPet) {
                      return Center(
                        child: CircularProgressIndicator(color: MColors.blue),
                      );
                    }
                    if (controller.pets.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum Pet encontrado.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.pets.length,
                        itemBuilder: (context, index) {
                          final pets = controller.pets[index];
                          return ListTile(
                            title: Text(pets.nome),
                            subtitle: Text(
                              'Nascimento: ${DateFormat('dd/MM/yyyy').format(pets.nascimento)}\n'
                              'Raça: ${pets.raca}\n'
                              'Peso: ${pets.peso}\n'
                              'Porte: ${pets.porte}\n'
                              'Tutor: ${pets.tutor}\n',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    controller.preencherCamposPet(pets);
                                    controller.isUpdatePet = true;
                                    controller.petIdToUpdate = pets.id!;
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _confirmarExclusao(pets);
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
          onChanged: onChanged,
          readOnly: readOnly,
        ),
      ],
    );
  }

  Widget buildDateField(String label, String hint,
      {required Function(DateTime) onDateSelected,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null && pickedDate != dataNascimento) {
              setState(() {
                dataNascimento = pickedDate;
                controller.nascimentoPetController.text =
                    DateFormat('dd/MM/yyyy').format(dataNascimento!);
                calcularIdade(controller.nascimentoPetController.text);
              });
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller.nascimentoPetController,
              decoration: InputDecoration(
                hintText: hint,
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              validator: validator,
            ),
          ),
        ),
      ],
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

  void _confirmarExclusao(Pet pet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Pets'),
          content: const Text('Tem certeza que deseja excluir o pet?'),
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
                await controller.deletePets(pet);
              },
            ),
          ],
        );
      },
    );
  }
}
