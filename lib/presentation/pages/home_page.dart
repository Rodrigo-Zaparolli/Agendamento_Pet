import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/presentation/screen/agendamentos_screen.dart';
import 'package:agendamento_pet/presentation/screen/clientes_screen.dart';
import 'package:agendamento_pet/presentation/screen/dashboard_screen.dart';
import 'package:agendamento_pet/presentation/screen/pets_screen.dart';
import 'package:agendamento_pet/presentation/screen/relatorios_screen.dart';
import 'package:agendamento_pet/presentation/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> _children = [
    DashboardScreen(),
    const AgendamentosScreen(),
    ClientesScreen(),
    const PetsScreen(),
    const RelatoriosScreen(),
    const RelatoriosScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<IconData> _tabIcons = [
    Icons.home,
    Icons.calendar_month,
    Icons.person,
    Icons.pets,
    Icons.receipt_rounded,
  ];

  final List<String> _appBarTitle = [
    "Dashboard",
    "Agendamentos",
    "Clientes",
    "Pets",
    "Relatórios",
    "Relatórios",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
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
        // padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: BottomNavigationBar(
          elevation: 5.0,
          selectedItemColor: MColors.blue,
          unselectedItemColor: MColors.textGrey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: MColors.cian,
          onTap: onTabTapped,
          items: _tabIcons.map((icon) {
            final bool isSelected = _tabIcons.indexOf(icon) == _currentIndex;
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
    );
  }
}
