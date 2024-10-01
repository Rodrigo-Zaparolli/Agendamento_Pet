// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  // Controllers
  final ctrlNome = TextEditingController();
  final ctrlSenha = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();

  // Keys
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  // State variables
  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? name;

  @observable
  String? phone;

  @observable
  String? error;

  @observable
  bool autoValidate = false;

  @observable
  bool isButtonDisabled = false;

  @observable
  bool obscureText = true;

  @observable
  bool isEnabled = true;

  _LoginControllerBase();

  final maskTextInputFormatter = MaskTextInputFormatter(
      mask: "+## (##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  // Validators

  @action
  String? validateName(String? val) {
    if (val!.isEmpty) {
      return "Informe seu nome";
    } else if (val.length < 2) {
      return "O nome deve ter pelo menos 2 caracteres";
    } else if (val.length > 20) {
      return "O nome é muito longo";
    } else {
      return null;
    }
  }

  @action
  String? validateEmail(String? val) {
    if (!val!.contains("@") || !val.contains(".")) {
      return "Informe seu endereço de email válido";
    } else if (val.isEmpty) {
      return "Informe seu endereço de email";
    } else {
      return null;
    }
  }

  @action
  String? validatePassword(String? val) {
    String pattern = r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = RegExp(pattern);
    if (val!.isEmpty) {
      return "Informe a senha";
    } else if (val.length < 6 || !regex.hasMatch(val)) {
      return "Sua senha não é forte o suficiente!";
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(String? val) {
    if (val!.length < 15) {
      return "Informe um telefone válido";
    } else {
      return null;
    }
  }

  // logar no sistema
  @action
  login() async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          // Perform login logic here
        }
      }
    } catch (e) {
      // Handle exceptions
    } finally {
      // Clean up or finalize login process
    }
  }

  // cadastrar usuário
  @action
  cadastrar() async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          // Perform login logic here
        }
      }
    } catch (e) {
      // Handle exceptions
    } finally {
      // Clean up or finalize login process
    }
  }

  //alterar senha

  @action
  redefinir() async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          // Perform login logic here
        }
      }
    } catch (e) {
      // Handle exceptions
    } finally {
      // Clean up or finalize login process
    }
  }

  @action
  void togglePasswordVisibility() {
    obscureText = !obscureText;
  }
}
