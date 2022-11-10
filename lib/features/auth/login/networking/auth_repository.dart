import 'dart:async';

import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._dioClient);

  final Dio _dioClient;

  Future<DC<AlertModel, AuthModel>> login({
    required String username,
    required String password,
  }) async {
    // Normally you should wrap the request with dioExceptionHandler.
    // Where error is catched and the returned error message is parsed to
    // create alert. But for the demo I will create alert without localization.

    final isIdPwCorrect = username == 'test' && password == 'test';

    if (isIdPwCorrect) {
      final user = UserModel.initial();
      final auth = AuthModel(
        tokenType: 'Bearer ',
        accessToken: '',
        refreshToken: '',
        user: user,
      );

      Timer(const Duration(seconds: 3), () {});

      return DC.data(auth);
    } else {
      final alert = AlertModel.alert(
        message: 'ID or PW is wrong. Please enter test for demo to both fields.',
        type: AlertType.destructive,
      );

      return DC.error(alert);
    }
  }

  Future<DC<AlertModel, void>> logout({required AuthModel auth}) async {
    try {
      // TODO: Implement custom logout operation with auth model.

      return DC.data(null);
    } catch (e) {
      return DC.error(AlertModel.quiet());
    }
  }
}
