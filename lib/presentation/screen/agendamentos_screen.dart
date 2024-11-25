// ignore_for_file: use_build_context_synchronously, avoid_print

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
    controller.getUserDetails();
    controller.fetchPets();
    controller.carregarAgendamentos();
    controller.fecthServico();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => CustomContainerWidget(
          color: MColors.cian,
          child: Column(
            children: [
              _buildAgendamentoListSection(),
            ],
          ),
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
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            "Agendamento de Serviço",
            style: boldFont(Colors.black, 20.0),
          ),
          content: SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.7,
            child: SingleChildScrollView(
              child: Observer(
                builder: (_) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPetDropdown(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: buildTextField('Tutor', 'Tutor',
                                    controller.tutorPetController),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildTextField('Raça:', 'Raça',
                                    controller.racaPetController),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildTextField('Idade:', 'Idade do pet',
                                    controller.idadePetController),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildTextField('Peso:', 'Peso do pet',
                                    controller.pesoPetController),
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
                          _buildDateSlotField(context),
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
                              onPressed: () async {
                                await _confirmarAgendamento();
                                Navigator.of(context).pop();
                              },
                              color: MColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  onChanged: (value) => controller.searchAgendamentos(value),
                ),
                const SizedBox(height: 16),
                Observer(
                  builder: (_) {
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: MColors.blue),
                      );
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.agendamentos.length,
                              itemBuilder: (context, index) {
                                final agendamento =
                                    controller.agendamentos[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(agendamento.petNome),
                                      subtitle: Text(
                                        'Tutor: ${agendamento.tutor} / '
                                        'Raça: ${agendamento.raca} / '
                                        'Idade: ${agendamento.idade} anos / '
                                        'Peso: ${agendamento.peso} kg / '
                                        'Serviço: ${agendamento.servico.nome} / '
                                        'Data: ${DateFormat('dd/MM/yyyy').format(agendamento.data)} / '
                                        'Hora: ${agendamento.hora}',
                                      ),
                                      leading: controller.role == 'manager'
                                          ? SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Checkbox(
                                                focusColor: MColors.teal,
                                                hoverColor: MColors.teal,
                                                value: agendamento.isRealizado,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    agendamento.isRealizado =
                                                        value ?? false;
                                                  });
                                                  controller
                                                      .atualizarStatusRealizado(
                                                          agendamento);
                                                  controller
                                                      .carregarAgendamentos();
                                                },
                                              ),
                                            )
                                          : Container(),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          _confirmarExclusao(
                                              context, agendamento);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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

  Widget _buildDateSlotField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Data:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.dataController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'dd/MM/yyyy',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          controller.selectedDate = pickedDate;
                          controller.dataController.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);

                          // Limpa o slot selecionado
                          controller.selectedTimeSlot = null;
                        });

                        List<String> availableSlots =
                            await controller.getAvailableTimeSlots(pickedDate);
                        setState(() {
                          controller.availableTimeSlots = availableSlots;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10), // Espaço entre os campos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Horário:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: controller.selectedTimeSlot,
                    items: controller.availableTimeSlots.map((time) {
                      return DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        controller.selectedTimeSlot = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Selecione um horário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
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
        // Filtra os serviços de acordo com o porte do pet selecionado
        final servicosFiltrados =
            controller.getServicosPorPorte(controller.selectedPet);

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
                  items: servicosFiltrados.map((servico) {
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
            hintText: 'dd/MM/yyyy, --:--',
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
            );

            if (pickedDate != null) {
              controller.selectedDate = pickedDate;

              List<TimeOfDay> availableTimes = [];
              for (int hour = 8; hour <= 18; hour++) {
                if (hour == 12) continue;
                availableTimes.add(TimeOfDay(hour: hour, minute: 0));
                if (hour < 18) {
                  availableTimes.add(TimeOfDay(hour: hour + 1, minute: 0));
                }
              }

              final selectedTime = await showModalBottomSheet<TimeOfDay>(
                context: context,
                builder: (BuildContext context) {
                  return ListView(
                    children: availableTimes.map((time) {
                      return ListTile(
                        title: Text(time.format(context)),
                        onTap: () {
                          Navigator.pop(context, time);
                        },
                      );
                    }).toList(),
                  );
                },
              );

              if (selectedTime != null) {
                // Formata e salva a data e hora selecionada
                DateTime selectedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );

                // Atualiza o controlador e a data formatada
                setState(() {
                  controller.selectedDate = selectedDateTime;
                  controller.dataController.text =
                      DateFormat('dd/MM/yyyy, HH:mm').format(selectedDateTime);

                  // Formatação correta da hora
                  controller.selectedTimeSlot =
                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

                  print(
                      'Hora selecionada: ${controller.selectedTimeSlot}'); // Para debug
                });
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> _confirmarAgendamento() async {
    try {
      if (controller.selectedPet == null ||
          controller.selectedServico == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Por favor, selecione um pet e serviço.')),
        );
        return;
      }

      // Verifique se a hora foi selecionada
      if (controller.selectedTimeSlot == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um horário.')),
        );
        return;
      }

      // Cria o agendamento
      final String userId = controller.currentUserId;
      final agendamento = Agendamento(
        petNome: controller.selectedPet!.nome,
        raca: controller.racaPetController.text,
        tutor: controller.tutorPetController.text,
        idade: controller.idadePetController.text,
        peso: controller.pesoPetController.text,
        sexo: controller.selectedSexo!,
        data: controller.selectedDate!,
        hora: controller.selectedTimeSlot!,
        servico: controller.selectedServico!,
        petId: controller.selectedPet!.clientId,
        userId: userId,
        motivoCancel: '',
        isRealizado: false,
      );

      // Salva o agendamento
      await controller.salvarAgendamento(agendamento, context);
      controller.clearAgendamentoFields();
      controller.restoreInitialDateField();

      setState(() {
        Navigator.of(context).pop();
      });
    } catch (e) {
      print(e);
    }
  }

  void _confirmarExclusao(BuildContext context, Agendamento agendamento) {
    final TextEditingController motivoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancelar Agendamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Tem certeza que deseja cancelar o agendamento de ${agendamento.petNome}?'),
              const SizedBox(height: 16),
              TextField(
                controller: motivoController,
                decoration: const InputDecoration(
                  labelText: 'Motivo do Cancelamento',
                  hintText: 'Digite o motivo',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmar Cancelamento'),
              onPressed: () async {
                final String motivo = motivoController.text.trim();
                if (motivo.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Por favor, informe o motivo do cancelamento.')),
                  );
                  return;
                }

                Navigator.of(context).pop();

                // Exclui o agendamento ou realiza a atualização
                await controller.updateAgendamento(
                    agendamento.id!, agendamento, motivo);

                // Recarrega os agendamentos após a exclusão
                await controller.carregarAgendamentos();
              },
            ),
          ],
        );
      },
    );
  }
}
