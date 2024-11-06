import 'package:agendamento_pet/controller/home_controller.dart';
import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/widget_stateful.dart';
import 'package:agendamento_pet/presentation/screen/agendamentos_screen.dart';
import 'package:agendamento_pet/presentation/screen/clientes_screen.dart';
import 'package:agendamento_pet/presentation/screen/dashboard_screen.dart';
import 'package:agendamento_pet/presentation/screen/servico_screen.dart';
import 'package:agendamento_pet/presentation/screen/pets_screen.dart';
import 'package:agendamento_pet/presentation/screen/relatorios_screen.dart';
import 'package:agendamento_pet/presentation/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.getUserDetails();
  }

  int _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> get _children {
    if (controller.role == 'manager') {
      return const [
        DashboardScreen(),
        ClientesScreen(),
        PetsScreen(),
        AgendamentosScreen(),
        RelatoriosScreen(),
        ServicosScreen(),
      ];
    } else {
      return const [
        ClientesScreen(),
        PetsScreen(),
        AgendamentosScreen(),
      ];
    }
  }

  List<IconData> get _tabIcons {
    if (controller.role == 'manager') {
      return [
        Icons.home,
        Icons.person,
        Icons.pets,
        Icons.calendar_month,
        Icons.receipt_rounded,
        Icons.settings,
      ];
    } else {
      return [
        Icons.person,
        Icons.pets,
        Icons.calendar_month,
      ];
    }
  }

  List<String> get _appBarTitle {
    if (controller.role == 'manager') {
      return [
        "Home",
        "Clientes",
        "Pets",
        "Agendamentos",
        "Relatórios",
        "Manutenções",
      ];
    } else {
      return [
        "Clientes",
        "Pets",
        "Agendamentos",
      ];
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: CustomAppBarWidget(
                backgroundColor: MColors.blue,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/user"),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ],
                title: Text(
                  _appBarTitle[_currentIndex],
                  style: boldFont(Colors.white, 20.0),
                ),
              ),
              body: PageStorage(
                bucket: bucket,
                child: _children[_currentIndex],
              ),
              bottomNavigationBar: Container(
                color: MColors.primaryWhite,
                child: BottomNavigationBar(
                  elevation: 5.0,
                  selectedItemColor: MColors.blue,
                  unselectedItemColor: MColors.textGrey,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: MColors.cian,
                  onTap: onTabTapped,
                  items: _tabIcons.map((icon) {
                    final bool isSelected =
                        _tabIcons.indexOf(icon) == _currentIndex;
                    return BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          icon,
                          color: isSelected ? MColors.blue : MColors.textGrey,
                          size: 28.0,
                        ),
                      ),
                      label: _appBarTitle[_tabIcons.indexOf(icon)],
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
