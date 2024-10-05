// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:agendamento_pet/constants/app_shared_preferences.dart';
import 'package:agendamento_pet/constants/dialog_helper.dart';
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
  final DialogHelper _helper;

  _LoginControllerBase(this._firebaseUsecase, this._helper);

  final sHandler = AppSharedPreferences();

  // Controladores de Texto
  final ctrlNome = TextEditingController();
  final ctrlSenha = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPhone = TextEditingController();

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
      mask: "+## (##) #####-####", filter: {"#": RegExp(r'[0-9]')});

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

  // Função principal de login/cadastro
  @action
  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      _firstLogin ? await _signUp(context) : await _signIn(context);
    }
  }

  // Função de login
  @action
  Future<void> _signIn(BuildContext context) async {
    _loading = true;
    try {
      await _helper.showSuccessDialog(context, "Realizando acesso, aguarde...");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: ctrlEmail.text,
        password: ctrlSenha.text,
      );

      final userDetails =
          await _firebaseUsecase.getUserDetails(userCredential.user!.uid);
      ctrlNome.text = userDetails?.name ?? '';
      ctrlEmail.text = userDetails?.email ?? '';
      userPhotoURL = userDetails?.photoURL ?? '';

      await saveCampos();
      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      await _helper.showErrorDialog(
          context, "Erro ao fazer login: ${e.message}");
    } finally {
      _loading = false;
    }
  }

  // Função de cadastro
  @action
  Future<void> _signUp(BuildContext context) async {
    _loading = true;
    try {
      await _helper.showSimpleMessage(
          context, "Realizando cadastro, aguarde...");
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
          city: "");

      await _firebaseUsecase.registerUser(usuario);

      await saveCampos();
      await _helper.showSuccessDialog(
          context, "Cadastro realizado com sucesso!");
      Navigator.of(context).pushNamed("/home");
    } on FirebaseAuthException catch (e) {
      await _helper.showErrorDialog(
        context,
        "Erro ao criar conta: ${e.message}",
      );
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> saveCampos() async {
    await sHandler.savePreferences("name", ctrlNome.text.trim());
    await sHandler.savePreferences("mail", ctrlEmail.text.trim());
    await sHandler.savePreferences("password", ctrlSenha.text.trim());
  }

  // Função para cadastrar usuário (separada, se necessário)
  @action
  Future<void> cadastrar(BuildContext context) async {
    _firstLogin = false;
    await login(context);
  }

  // Função para redefinir a senha
  @action
  Future<void> redefinir(BuildContext context) async {
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          await _auth.sendPasswordResetEmail(email: ctrlEmail.text);
          await _helper.showSuccessDialog(
              context, "Email de redefinição de senha enviado!");
        }
      }
    } catch (e) {
      await _helper.showErrorDialog(context, "Erro ao redefinir senha: $e");
    }
  }

  @action
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    await sHandler.clearPreferences();
    Navigator.of(context).pushNamedAndRemoveUntil("/index", (route) => false);
  }
}
