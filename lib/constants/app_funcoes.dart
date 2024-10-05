import 'package:agendamento_pet/constants/app_shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppFuncoes {
  Future<bool> isConfigured() async {
    final auth = FirebaseAuth.instance;
    final handler = AppSharedPreferences();

    final User? user = auth.currentUser;

    if (user != null) {
      final String edtMail = await handler.readPreferences("mail");
      final String edtPwd = await handler.readPreferences("password");

      if (user.providerData
          .any((provider) => provider.providerId == 'password')) {
        if (edtMail.isNotEmpty && edtPwd.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        true;
        return true;
      }
    }

    return false;
  }
}
