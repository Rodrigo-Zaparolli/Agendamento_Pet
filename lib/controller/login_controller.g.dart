// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  late final _$emailAtom =
      Atom(name: '_LoginControllerBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginControllerBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_LoginControllerBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_LoginControllerBase.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_LoginControllerBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$autoValidateAtom =
      Atom(name: '_LoginControllerBase.autoValidate', context: context);

  @override
  bool get autoValidate {
    _$autoValidateAtom.reportRead();
    return super.autoValidate;
  }

  @override
  set autoValidate(bool value) {
    _$autoValidateAtom.reportWrite(value, super.autoValidate, () {
      super.autoValidate = value;
    });
  }

  late final _$isButtonDisabledAtom =
      Atom(name: '_LoginControllerBase.isButtonDisabled', context: context);

  @override
  bool get isButtonDisabled {
    _$isButtonDisabledAtom.reportRead();
    return super.isButtonDisabled;
  }

  @override
  set isButtonDisabled(bool value) {
    _$isButtonDisabledAtom.reportWrite(value, super.isButtonDisabled, () {
      super.isButtonDisabled = value;
    });
  }

  late final _$obscureTextAtom =
      Atom(name: '_LoginControllerBase.obscureText', context: context);

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  late final _$isEnabledAtom =
      Atom(name: '_LoginControllerBase.isEnabled', context: context);

  @override
  bool get isEnabled {
    _$isEnabledAtom.reportRead();
    return super.isEnabled;
  }

  @override
  set isEnabled(bool value) {
    _$isEnabledAtom.reportWrite(value, super.isEnabled, () {
      super.isEnabled = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_LoginControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$_firstLoginAtom =
      Atom(name: '_LoginControllerBase._firstLogin', context: context);

  @override
  bool get _firstLogin {
    _$_firstLoginAtom.reportRead();
    return super._firstLogin;
  }

  @override
  set _firstLogin(bool value) {
    _$_firstLoginAtom.reportWrite(value, super._firstLogin, () {
      super._firstLogin = value;
    });
  }

  late final _$userPhotoURLAtom =
      Atom(name: '_LoginControllerBase.userPhotoURL', context: context);

  @override
  String? get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String? value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginControllerBase.login', context: context);

  @override
  Future<void> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$_signInAsyncAction =
      AsyncAction('_LoginControllerBase._signIn', context: context);

  @override
  Future<void> _signIn(BuildContext context) {
    return _$_signInAsyncAction.run(() => super._signIn(context));
  }

  late final _$_signUpAsyncAction =
      AsyncAction('_LoginControllerBase._signUp', context: context);

  @override
  Future<void> _signUp(BuildContext context) {
    return _$_signUpAsyncAction.run(() => super._signUp(context));
  }

  late final _$saveCamposAsyncAction =
      AsyncAction('_LoginControllerBase.saveCampos', context: context);

  @override
  Future<void> saveCampos() {
    return _$saveCamposAsyncAction.run(() => super.saveCampos());
  }

  late final _$cadastrarAsyncAction =
      AsyncAction('_LoginControllerBase.cadastrar', context: context);

  @override
  Future<void> cadastrar(BuildContext context) {
    return _$cadastrarAsyncAction.run(() => super.cadastrar(context));
  }

  late final _$redefinirAsyncAction =
      AsyncAction('_LoginControllerBase.redefinir', context: context);

  @override
  Future<void> redefinir(BuildContext context) {
    return _$redefinirAsyncAction.run(() => super.redefinir(context));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_LoginControllerBase.logout', context: context);

  @override
  Future<void> logout(BuildContext context) {
    return _$logoutAsyncAction.run(() => super.logout(context));
  }

  late final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase', context: context);

  @override
  String? validateName(String? val) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validateName');
    try {
      return super.validateName(val);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateEmail(String? val) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validateEmail');
    try {
      return super.validateEmail(val);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validatePassword(String? val) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validatePassword');
    try {
      return super.validatePassword(val);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validatePhoneNumber(String? val) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(val);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
name: ${name},
phone: ${phone},
error: ${error},
autoValidate: ${autoValidate},
isButtonDisabled: ${isButtonDisabled},
obscureText: ${obscureText},
isEnabled: ${isEnabled},
userPhotoURL: ${userPhotoURL}
    ''';
  }
}
