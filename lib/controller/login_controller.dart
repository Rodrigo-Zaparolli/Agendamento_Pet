// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:agendamento_pet/constants/app_shared_preferences.dart';
import 'package:agendamento_pet/constants/dialog_helper.dart';
import 'package:agendamento_pet/constants/error_handler.dart';
import 'package:agendamento_pet/domain/model/usuario.dart';
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseUsecase _firebaseUsecase;

  _LoginControllerBase(this._firebaseUsecase);

  final sHandler = AppSharedPreferences();
  final dHelper = DialogHelper();

  // Controladores de Texto
  final ctrlNome = TextEditingController();
  final ctrlSenha = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlRole = TextEditingController();

  // Chaves
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  // Variáveis de Estado
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

  @observable
  bool _loading = false;

  @observable
  bool _firstLogin = true;

  @observable
  String? userPhotoURL;

  // Formatter
  final maskTextInputFormatter = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  @action
  initState() async {
    try {
      _loading = true;
    } finally {
      _loading = false;
    }
  }

  // Validators
  @action
  String? validateName(String? val) {
    if (val == null || val.isEmpty) {
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
    if (val == null || val.isEmpty) {
      return "Informe seu endereço de email";
    } else if (!val.contains("@") || !val.contains(".")) {
      return "Informe seu endereço de email válido";
    } else {
      return null;
    }
  }

  @action
  String? validatePassword(String? val) {
    String pattern = r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = RegExp(pattern);
    if (val == null || val.isEmpty) {
      return "Informe a senha";
    } else if (val.length < 6 || !regex.hasMatch(val)) {
      return "Sua senha não é forte o suficiente!";
    } else {
      return null;
    }
  }

  @action
  String? validatePhoneNumber(String? val) {
    if (val == null || val.length < 15) {
      return "Informe um telefone válido";
    } else {
      return null;
    }
  }

  // Função para alternar a visibilidade da senha
  @action
  void togglePasswordVisibility() {
    obscureText = !obscureText;
  }

  // Função de login
  @action
  Future<void> signIn(BuildContext context) async {
    _loading = true;
    try {
      dHelper.showSimpleMessage(context, "Realizando acesso, aguarde...");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: ctrlEmail.text,
        password: ctrlSenha.text,
      );

      Navigator.of(context).pop();

      final userDetails =
          await _firebaseUsecase.getUserDetails(userCredential.user!.uid);

      if (userDetails != null) {
        ctrlNome.text = userDetails.name;
        ctrlEmail.text = userDetails.email;
        ctrlRole.text = userDetails.role;

        Navigator.of(context).pushNamed("/home");

        await saveCampos();
      } else {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'Usuário não encontrado');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

      String errorMessage = ErrorHandler.getErrorMessage(e);

      await dHelper.showErrorDialog(context, errorMessage);
    } finally {
      _loading = false;
    }
  }

  // Função de cadastro
  @action
  Future<void> signUp(BuildContext context) async {
    _loading = true;
    try {
      dHelper.showSimpleMessage(context, "Realizando cadastro, aguarde...");

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: ctrlEmail.text,
        password: ctrlSenha.text,
      );

      await userCredential.user?.updateProfile(displayName: ctrlNome.text);

      final usuario = Usuario(
          id: userCredential.user!.uid,
          name: ctrlNome.text,
          email: ctrlEmail.text,
          photoURL: userPhotoURL,
          cpf: "",
          birthDate: "",
          phone: ctrlPhone.text,
          cep: "",
          state: "",
          city: "",
          role: "");

      await _firebaseUsecase.registerUser(usuario);

      await saveCampos();

      Navigator.of(context).pop();

      await dHelper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");

      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

      String errorMessage = ErrorHandler.getErrorMessage(e);

      await dHelper.showErrorDialog(context, errorMessage);
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> saveCampos() async {
    await sHandler.savePreferences("name", ctrlNome.text.trim());
    await sHandler.savePreferences("mail", ctrlEmail.text.trim());
    await sHandler.savePreferences("password", ctrlSenha.text.trim());
    await sHandler.savePreferences("role", ctrlRole.text.trim());
  }

  setaCampos() async {
    ctrlNome.text = await sHandler.readPreferences("name");
    ctrlEmail.text = await sHandler.readPreferences("mail");
    ctrlSenha.text = await sHandler.readPreferences("password");
    ctrlRole.text = await sHandler.readPreferences("role");
  }

  // Função para redefinir a senha
  @action
  Future<void> redefinir(BuildContext context) async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          await _auth.sendPasswordResetEmail(email: ctrlEmail.text);
          await dHelper.showSuccessDialog(
              context, "Email de redefinição de senha enviado!");
        }
      }
    } catch (e) {
      await dHelper.showErrorDialog(context, "Erro ao redefinir senha: $e");
    }
  }

  @action
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    await sHandler.clearPreferences();
    Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
  }
}
