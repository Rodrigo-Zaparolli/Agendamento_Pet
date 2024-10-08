import 'package:agendamento_pet/core/utils/all_widgets.dart';
import 'package:agendamento_pet/core/utils/colors.dart';
import 'package:agendamento_pet/core/utils/strings.dart';
import 'package:agendamento_pet/presentation/pages/login_page.dart';
import 'package:agendamento_pet/presentation/pages/registration_page.dart';
import 'package:agendamento_pet/presentation/widgets/custom_buttom_widget.dart';
import 'package:agendamento_pet/presentation/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        _showCloseAppDialog(context);
      },
      child: Scaffold(
        body: CustomContainerWidget(
          color: MColors.cian,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/petshop.png",
                    height: 300,
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  "Bem-vindo ao Pet Shop",
                  style: boldFont(MColors.textDark, 30.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  Strings.onBoardTitle_sub1,
                  style: normalFont(MColors.textGrey, 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          color: MColors.cian,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButtomWidget(
                  buttonChild: Text(
                    "Entrar",
                    style: boldFont(MColors.primaryWhite, 16.0),
                  ),
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      ),
                  color: MColors.blue),
              const SizedBox(
                height: 10.0,
              ),
              CustomButtomWidget(
                  buttonChild: Text(
                    "Criar uma conta",
                    style: boldFont(MColors.blue, 16.0),
                  ),
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegistrationPage(),
                        ),
                      ),
                  color: MColors.primaryPlatinum),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCloseAppDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Are you sure you want to leave?",
              style: normalFont(MColors.textGrey, 14.0),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: normalFont(MColors.textGrey, 14.0),
                ),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  "Leave",
                  style: normalFont(Colors.redAccent, 14.0),
                ),
              ),
            ],
          );
        });
  }
}
