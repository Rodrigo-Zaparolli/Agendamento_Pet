import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandler {
  static String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email inválido';
      case 'weak-password':
        return 'A senha é muito fraca';
      case 'email-already-in-use':
        return 'Este e-mail já está sendo utilizado';
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'operation-not-allowed':
        return 'Cadastro de conta desativado';
      case 'invalid-credential':
        return 'As credenciais fornecidas estão incorretas. Por favor, verifique sua senha!';
      default:
        return 'Erro: ${e.message}';
    }
  }
}
