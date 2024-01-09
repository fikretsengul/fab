// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/forms/login.form.dart';
import '../cubits/login.cubit.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({required this.onResult, super.key});

  final Function(bool didLogin) onResult;

  final loginCubit = $.get<LoginCubit>();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final isSucceeded = await loginCubit.login(email: email, password: password);

    if (isSucceeded) {
      onResult(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (_, state) {
        $.debug(state);
        state.whenOrNull(
          loading: () => $.overlay.showLoadingOverlay(),
          failed: (failure) {
            $.overlay.hideOverlay();
            $.toast.showToast(message: failure.message);
          },
          succeeded: (user) {
            $.overlay.hideOverlay();
            $.get<UserCubit>().loggedIn(user);
          },
        );
      },
      child: Scaffold(
        body: LoginFormFormBuilder(
          model: LoginForm.empty(),
          builder: (_, data, __) {
            return PaddingAll.md(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FabReactiveTextfield(
                    formControl: data.emailControl,
                    keyboardType: TextInputType.emailAddress,
                    labelText: $.tr.auth.loginForm.email,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => data.passwordControl.focus(),
                  ),
                  PaddingGap.xs(),
                  FabReactiveTextfield(
                    formControl: data.passwordControl,
                    keyboardType: TextInputType.text,
                    labelText: $.tr.auth.loginForm.password,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => data.form.valid
                        ? login(email: data.emailControl.value ?? '', password: data.passwordControl.value ?? '')
                        : null,
                  ),
                  ReactiveLoginFormFormConsumer(
                    builder: (_, __, ___) {
                      return ElevatedButton(
                        onPressed: data.form.valid
                            ? () =>
                                login(email: data.emailControl.value ?? '', password: data.passwordControl.value ?? '')
                            : null,
                        child: Text($.tr.auth.loginForm.loginButton),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
