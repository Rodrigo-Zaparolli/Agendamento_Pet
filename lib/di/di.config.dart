// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:agendamento_pet/controller/dashboard_controller.dart' as _i75;
import 'package:agendamento_pet/controller/login_controller.dart' as _i32;
import 'package:agendamento_pet/di/dio_di.dart' as _i1015;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioDi = _$DioDi();
    gh.factory<_i361.BaseOptions>(() => dioDi.options);
    gh.factory<_i32.LoginController>(() => _i32.LoginController());
    gh.factory<_i75.DashboardController>(() => _i75.DashboardController());
    gh.lazySingleton<_i361.Dio>(() => dioDi.dio());
    return this;
  }
}

class _$DioDi extends _i1015.DioDi {}
