// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../../../data/auth.service.dart';

part 'login.cubit.freezed.dart';
part 'states/login.state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._service) : super(const LoginStateInitial());

  final AuthService _service;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    var didLogin = false;

    emit(const LoginStateLoading());

    final response = await _service.login(email, password);

    response.fold(
      (failure) => emit(LoginStateFailed(failure)),
      (user) {
        emit(LoginStateSucceeded(user));

        didLogin = true;
      },
    );

    return didLogin;
  }
}
