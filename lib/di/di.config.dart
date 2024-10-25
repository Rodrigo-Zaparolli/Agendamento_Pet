// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:agendamento_pet/controller/dashboard_controller.dart' as _i75;
import 'package:agendamento_pet/controller/login_controller.dart' as _i32;
import 'package:agendamento_pet/data/repository/busca_cep_repository.dart'
    as _i29;
import 'package:agendamento_pet/data/repository/firebase_repository.dart'
    as _i935;
import 'package:agendamento_pet/di/dio_di.dart' as _i1015;
import 'package:agendamento_pet/di/firebase_di.dart' as _i135;
import 'package:agendamento_pet/domain/usecase/busca_cep_usecase.dart' as _i279;
import 'package:agendamento_pet/domain/usecase/firebase_usecase.dart' as _i941;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final dioDi = _$DioDi();
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => firebaseModule.initFirebaseApp,
      preResolve: true,
    );
    gh.factory<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.factory<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.factory<_i361.BaseOptions>(() => dioDi.options);
    gh.lazySingleton<_i361.Dio>(() => dioDi.dio());
    gh.factory<_i29.BuscaCepRepository>(
        () => _i29.BuscaCepRepositoryImpl(gh<_i361.Dio>()));
    gh.factory<_i279.BuscaCepUseCase>(
        () => _i279.BuscaCepUseCaseImpl(gh<_i29.BuscaCepRepository>()));
    gh.factory<_i935.FirestoreRepository>(() => _i935.FirestoreRepositoryImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i941.FirebaseUsecase>(
        () => _i941.FirebaseUsecaseImpl(gh<_i935.FirestoreRepository>()));
    gh.factory<_i75.DashboardController>(() => _i75.DashboardController(
          gh<_i941.FirebaseUsecase>(),
          gh<_i279.BuscaCepUseCase>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i32.LoginController>(
        () => _i32.LoginController(gh<_i941.FirebaseUsecase>()));
    return this;
  }
}

class _$FirebaseModule extends _i135.FirebaseModule {}

class _$DioDi extends _i1015.DioDi {}
