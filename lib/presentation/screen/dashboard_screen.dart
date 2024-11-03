import 'package:agendamento_pet/controller/dashboard_controller.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends WidgetStateful<DashboardScreen, DashboardController> {
  @override
  void initState() {
    controller.fetchClients();
    controller.fetchPets();
    controller.carregarAgendamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainerWidget(
        color: MColors.cian,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;

              return Observer(
                  builder: (_) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildCard(
                                  icon: Icons.schedule,
                                  label: 'Agendamentos do mês',
                                  count: controller.agendamentosMes,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildCard(
                                  icon: Icons.schedule,
                                  label: 'Agendamentos do dia',
                                  count: controller.agendamentosDia,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildCard(
                                  icon: Icons.cancel,
                                  label: 'Cancelamentos do mês',
                                  count: 0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Responsive Column for Clients and Pets Sections
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: isMobile ? 1 : 2,
                                  child: _buildClientesSection(controller),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: isMobile ? 1 : 2,
                                  child: _buildPetsSection(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String label,
    required int count,
  }) {
    return SizedBox(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 10.sp, color: MColors.blue),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 5.sp,
                        fontWeight: FontWeight.bold,
                        color: MColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClientesSection(DashboardController controller) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.people, color: MColors.blue),
                const SizedBox(width: 8),
                Text(
                  'Clientes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MColors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Procurar cliente',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchClients(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String query = controller.searchController.text.trim();
                    controller.searchClients(query);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MColors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Observer(
              builder: (_) {
                if (controller.isLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: CircularProgressIndicator(color: MColors.blue),
                    ),
                  );
                } else if (controller.errorMessage.isNotEmpty) {
                  return Text(
                    controller.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (controller.clients.isEmpty) {
                  return const Text(
                    'Sem clientes.',
                    style: TextStyle(color: Colors.grey),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.clients.length,
                      itemBuilder: (context, index) {
                        final client = controller.clients[index];
                        return ListTile(
                          leading: Icon(Icons.person, color: MColors.blue),
                          title: Text(client.nome),
                          subtitle: Text(
                              'Nascimento: ${DateFormat('dd/MM/yyyy').format(client.dataNascimento)}\n'
                              'Telefone: ${client.telefone}\n'
                              'Cidade: ${client.cidade} - ${client.uf}'),
                          onTap: () {},
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pets, color: MColors.blue),
                const SizedBox(width: 8),
                Text(
                  'Pets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MColors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchPetController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Procurar Pets',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchPets(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String query = controller.searchPetController.text.trim();
                    controller.searchPets(query);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MColors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Observer(
              builder: (_) {
                if (controller.isLoadingPet) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                        child: CircularProgressIndicator(color: MColors.blue)),
                  );
                } else if (controller.errorMessagePet.isNotEmpty) {
                  return Text(
                    controller.errorMessagePet,
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (controller.pets.isEmpty) {
                  return const Text(
                    'Sem Pets cadastrados.',
                    style: TextStyle(color: Colors.grey),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.pets.length,
                      itemBuilder: (context, index) {
                        final pets = controller.pets[index];
                        final clients = controller.clients[index];
                        return GestureDetector(
                          child: ListTile(
                            leading: pets.raca == "Cão"
                                ? Icon(MdiIcons.cat, color: MColors.blue)
                                : Icon(MdiIcons.dog, color: MColors.blue),
                            title: Text(pets.nome),
                            subtitle: Text(
                              "${pets.tipo} - ${pets.raca}\n"
                              "Tutor: ${clients.nome}",
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
