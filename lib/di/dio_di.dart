// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioDi {
  final options = BaseOptions(
    baseUrl: '',
    headers: {"accept": "application/json"},
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
  );

  @lazySingleton
  Dio dio() {
    final dio = Dio(options);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onError: (error, handler) async {
          handler.reject(error);
        },
      ),
    );

    return dio;
  }
}
