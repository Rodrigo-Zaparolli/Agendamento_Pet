import 'package:flutter/material.dart';

const String indexRoute = "/index";
const String loginRoute = "/login";
const String cadastroRoute = "/cadastro";
const String atualizaCadastroRoute = "/atualizaCadastro";
const String homeRoute = "/home";
const String userRoute = "/user";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final BuildContext ctx = navigatorKey.currentContext!;
