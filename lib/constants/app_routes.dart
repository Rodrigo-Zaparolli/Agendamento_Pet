import 'package:agendamento_pet/constants/app_constanst.dart';
import 'package:agendamento_pet/presentation/pages/home_page.dart';
import 'package:agendamento_pet/presentation/pages/index_page.dart';
import 'package:agendamento_pet/presentation/pages/login_page.dart';
import 'package:agendamento_pet/presentation/pages/registration_page.dart';
import 'package:agendamento_pet/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indexRoute:
        return SlideRightRoute(widget: const IndexPage());
      case loginRoute:
        return SlideRightRoute(widget: const LoginPage());
      case cadastroRoute:
        return SlideRightRoute(widget: const RegistrationPage());
      case homeRoute:
        return SlideRightRoute(widget: const HomePage());
      case userRoute:
        return SlideRightRoute(widget: const UserPage());
      default:
        return SlideRightRoute(widget: const IndexPage());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
