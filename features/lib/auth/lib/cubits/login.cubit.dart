// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/analytics.dart';
import 'package:deps/infrastructure/commons.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../models/user.model.dart';
import '../services/auth.service.dart';

part 'login.cubit.freezed.dart';
part 'states/login.state.dart';

/// `LoginBloc` is a Bloc class that manages the login process.
/// It listens to login requests and emits states corresponding to different stages of the login process.
@injectable
class LoginBloc extends Cubit<LoginState> {
  /// Constructs `LoginBloc` with a dependency on `AuthService` and initializes with `LoginInitial` state.
  ///
  /// [_service]: The authentication service responsible for performing login operations.
  LoginBloc(this._service) : super(const LoginStateInitial());

  final AuthService _service;

  /// Initiates the login process with the provided credentials.
  ///
  /// Emits `LoginLoading` while the login process is ongoing.
  /// On completion, emits either `LoginSucceded` with user details or `LoginFailed` with the failure reason.
  ///
  /// [username]: The username for login.
  /// [password]: The password for login.
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    var didLogin = false;

    emit(const LoginStateLoading());

    final response = await _service.login(username, password);

    // Artificial delay for demonstration purposes.
    await Timings.sec.delay();

    // Handles the response from the login operation.
    response.fold(
      (failure) {
        emit(LoginStateFailed(failure));

        didLogin = false;
      },
      (user) {
        emit(LoginStateSucceeded(user));

        didLogin = true;
      },
    );

    return didLogin;
  }
}
