// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../blocs/auth.bloc.dart';

/// Extension on `BlocBase<AuthState>` to provide a `ValueListenable<bool>` for authentication status.
///
/// This extension enables widgets to reactively listen to changes in the authentication status
/// without directly subscribing to the entire `AuthState` stream. It simplifies the process of
/// checking if the user is authenticated and updating UI components accordingly.
extension AuthStateToBoolListenableExtension on BlocBase<AuthState> {
  /// Creates a `ValueListenable<bool>` that listens to the authentication state and updates
  /// its value based on whether the user is authenticated.
  ///
  /// Returns a `ValueListenable<bool>` where the value is `true` if the user is authenticated,
  /// and `false` otherwise. This is useful for widgets that need to know the authentication status
  /// but do not require the full details of the `AuthState`.
  ValueListenable<bool> isAuthenticatedListenable() {
    final notifier = ValueNotifier<bool>(state is AuthAuthenticated);
    stream.listen((value) {
      notifier.value = value is AuthAuthenticated;
    });

    return notifier;
  }
}
