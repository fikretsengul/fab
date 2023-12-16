// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/networking.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../others/enums.dart';

part 'auth.cubit.freezed.dart';
part 'states/auth.state.dart';

/// `AuthCubit` is a Bloc class that manages the authentication state of the application.
/// It listens to changes in authentication status and emits corresponding states.
@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  /// Constructs `AuthCubit` with dependencies and initializes with `AuthLoading` state.
  ///
  /// [DioTokenRefresh]: The dependency for managing token-based authentication.
  AuthCubit(this._dioTokenRefresh) : super(const AuthLoading()) {
    // Listens to changes in authentication status and updates the state accordingly.
    _dioTokenRefresh.interceptor.authStatus.listen(
      (status) async {
        if (status == AuthStatus.authenticated) {
          // Emits `AuthAuthenticated` when the user is authenticated.
          emit(const AuthAuthenticated());
        } else if (status == AuthStatus.unauthenticated) {
          // Emits `AuthUnauthenticated` when the user is not authenticated.
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  final DioTokenRefresh _dioTokenRefresh;
}
