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
    final isIdPwCorrect = username == 'test' && password == 'test';

    if (isIdPwCorrect) {
      final user = UserModel.initial();
      final auth = AuthModel(
        tokenType: 'Bearer ',
        accessToken: 'demo_access_token',
        refreshToken: 'demo_refresh_token',
        user: user,
      );

      return DC.data(auth);
    } else {
      print('noluyo amk');
      final alert = AlertModel.quiet();

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
