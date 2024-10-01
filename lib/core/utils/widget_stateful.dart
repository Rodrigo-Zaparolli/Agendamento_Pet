import 'package:agendamento_pet/di/di.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

abstract class WidgetStateful<Widget extends StatefulWidget,
    Controller extends Store> extends State<Widget> {
  final Controller controller = getIt<Controller>();
}
