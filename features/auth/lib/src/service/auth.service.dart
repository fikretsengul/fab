import 'dart:async';

import 'package:deps/core/commons/errors.dart';
import 'package:deps/core/commons/types.dart';
import 'package:deps/core/networking/networking.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/injectable.dart';

import '../model/user.module.dart';
import '../others/failure/failures.dart';

@lazySingleton
class AuthService {
  AuthService(this._dio, this._dioTokenRefresh);

  // ignore: unused_field
  final DioClient _dio;
  final DioTokenRefresh _dioTokenRefresh;

  AsyncEither<User> login(
    String username,
    String password,
  ) async {
    // final request = await _dio.invoke('/login', RequestType.post);

    // return request.pick(
    //   onFailure: Either.failure,
    //   onData: (response) => Either.data(
    //     User.fromJson(response.data as Map<String, dynamic>),
    //   ),
    // );

    final isIdPwCorrect = username == 'test' && password == 'test';

    if (isIdPwCorrect) {
      final user = User.empty();

      await Future<void>.delayed(const Duration(seconds: 2));
      await _dioTokenRefresh.interceptor.setToken(OAuth2Token.empty());

      return Right(user);
    } else {
      return Left(WrongCredentialsFailure());
    }
  }

  AsyncEither<void> logout() async {
    try {
      // Implement custom logout operation.

      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
