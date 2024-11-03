// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:agendamento_pet/constants/app_shared_preferences.dart';
import 'package:agendamento_pet/constants/dialog_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

@injectable
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase();

  final sHandler = AppSharedPreferences();
  final dHelper = DialogHelper();

  @observable
  bool _loading = false;

  @computed
  bool get loading => _loading;

  @observable
  String role = "";

  @action
  initState() async {
    try {
      _loading = true;
    } finally {
      _loading = false;
    }
  }

  getUserDetails() async {
    _loading = true;
    role = await sHandler.readPreferences("role");
    _loading = false;
  }
}
