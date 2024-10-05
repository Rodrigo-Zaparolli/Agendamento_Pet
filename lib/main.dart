import 'package:agendamento_pet/constants/app_constanst.dart';
import 'package:agendamento_pet/constants/app_funcoes.dart';
import 'package:agendamento_pet/constants/app_routes.dart';
import 'package:agendamento_pet/di/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String tela = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyC04nnQ8YsS8821mTeJhodFAWboDKV8t-8",
    appId: "1:268548462362:web:bd0b38fbe17470d32a7ea3",
    messagingSenderId: "268548462362",
    projectId: "agendamento-b8f6e",
  ));
  configureInjection();
  tela = await AppFuncoes().isConfigured() ? "/home" : "/index";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agendamento PetShop',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: tela,
      navigatorKey: navigatorKey,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
