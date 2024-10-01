import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'dashboard_controller.g.dart';

@injectable
class DashboardController = _DashboardControllerBase with _$DashboardController;

abstract class _DashboardControllerBase with Store {
  @observable
  bool isAuthenticated = false;
}
