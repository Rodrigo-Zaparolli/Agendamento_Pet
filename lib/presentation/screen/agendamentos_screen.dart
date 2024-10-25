// ignore_for_file: use_build_context_synchronously

import 'package:agendamento_pet/controller/dashboard_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/domain/model/agendamento.dart';
import 'package:agendamento_pet/domain/model/pet.dart';
import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AgendamentosScreen extends StatefulWidget {
  const AgendamentosScreen({super.key});

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState
    extends WidgetStateful<AgendamentosScreen, DashboardController> {
  @override
  void initState() {
    controller.fetchPets();
    controller.carregarAgendamentos();
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
            _buildAgendamentoListSection(),
            _buildAgendamentoFormSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAgendamentoListSection() {
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
                      'Agendamentos',
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
                    hintText: 'Pesquisar agendamento',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    if (controller.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.agendamentos.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum agendamento encontrado.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.agendamentos.length,
                        itemBuilder: (context, index) {
                          final agendamento = controller.agendamentos[index];
                          return ListTile(
                            title: Text(agendamento.petNome),
                            subtitle: Text(
                              'Raça: ${agendamento.raca}, '
                              'Idade: ${agendamento.idade} anos, '
                              'Peso: ${agendamento.peso} kg\n'
                              'serviço: ${agendamento.servico.nome}\n'
                              'Data: ${DateFormat('dd/MM/yyyy').format(agendamento.dataHora)} '
                              'Hora: ${DateFormat('HH:mm').format(agendamento.dataHora)}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _confirmarExclusao(context, agendamento);
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

  Widget _buildAgendamentoFormSection(BuildContext context) {
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
                    Icon(Icons.pets, color: MColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Agendamento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildPetDropdown(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: buildTextField(
                          'Raça:', 'Raça', controller.racaPetController),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildTextField('Idade:', 'Idade do pet',
                          controller.idadePetController),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildTextField(
                          'Peso:', 'Peso do pet', controller.pesoPetController),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Sexo:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  value: controller.selectedSexo,
                  items: ['Escolha', 'Macho', 'Fêmea']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.selectedSexo = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16),
                _buildServicoDropdown(),
                const SizedBox(height: 16),
                buildDateField(context),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtomWidget(
                    buttonChild: Text(
                      'Confirmar Agendamento',
                      style: boldFont(
                        MColors.primaryWhite,
                        16.0,
                      ),
                    ),
                    onPressed: () => _confirmarAgendamento(context),
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

  Widget _buildPetDropdown() {
    return Observer(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pet:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<Pet>(
                  value: controller.selectedPet,
                  items: controller.pets.map((pet) {
                    return DropdownMenuItem(
                      value: pet,
                      child: Text(pet.nome),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.selectedPet = value;
                      if (controller.selectedPet != null) {
                        _fillPetDetails(controller.selectedPet!);
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Selecione um pet',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServicoDropdown() {
    return Observer(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Serviço:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<Servico>(
                  value: controller.selectedServico,
                  items: controller.servico.map((servico) {
                    return DropdownMenuItem(
                      value: servico,
                      child: Text(
                          "${servico.nome} - R\$ ${servico.preco.toStringAsFixed(2)}"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.selectedServico = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Selecione um serviço',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _fillPetDetails(Pet pet) {
    controller.racaPetController.text = pet.raca;
    controller.idadePetController.text = pet.idade.toString();
    controller.pesoPetController.text = pet.peso.toString();
    controller.selectedSexo = pet.sexo;
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Data e Hora:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller.dataController,
          readOnly: true,
          decoration: const InputDecoration(
            hintText: 'dd/MM/aaaa, --:--',
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            // Seleciona a data
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              // Seleciona a hora
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                // Combina data e hora
                final DateTime selectedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                // Formata data e hora
                setState(() {
                  controller.selectedDate = selectedDateTime;
                  controller.dataController.text =
                      DateFormat('dd/MM/yyyy, HH:mm').format(selectedDateTime);
                });
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> _confirmarAgendamento(BuildContext context) async {
    try {
      if (controller.selectedPet == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um pet.')),
        );
        return;
      }

      // Verifica se userId está disponível
      final String userId =
          controller.currentUserId; // Ajuste conforme necessário

      final agendamento = Agendamento(
        petNome: controller.selectedPet!.nome,
        raca: controller.racaPetController.text,
        idade: controller.idadePetController.text,
        peso: controller.pesoPetController.text,
        sexo: controller.selectedSexo!,
        dataHora: controller.selectedDate!,
        servico: controller.selectedServico!,
        petId: controller.selectedPet!.id,
        userId: userId,
      );

      bool existeAgendamentoNoMesmoHorario = controller.agendamentos
          .any((a) => a.dataHora.isAtSameMomentAs(agendamento.dataHora));

      if (existeAgendamentoNoMesmoHorario) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Já existe um agendamento para este horário.')),
        );
        return;
      }

      await controller.salvarAgendamento(agendamento, context);
    } catch (e) {
      print(e);
    }
  }

  void _confirmarExclusao(BuildContext context, Agendamento agendamento) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Agendamento'),
          content: Text(
              'Tem certeza que deseja excluir o agendamento de ${agendamento.petNome}?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o dialog
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                Navigator.of(context).pop(); // Fecha o dialog
                await controller
                    .excluirAgendamento(agendamento); // Exclui o agendamento
              },
            ),
          ],
        );
      },
    );
  }
}
