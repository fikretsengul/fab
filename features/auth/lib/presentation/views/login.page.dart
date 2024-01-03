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
  const LoginPage({required this.onResult, super.key});

  final Function(bool didLogin) onResult;

  Future<void> login() async {
    final isSucceeded = await $.get<LoginCubit>().login(
          email: 'test',
          password: 'test',
        );

    if (isSucceeded) {
      onResult(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $.get<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (_, state) {
          state.whenOrNull(
            //failed: (failure) => showAlertDialog(context, failure),
            succeeded: (user) => $.get<UserCubit>().loggedIn(user),
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
                      onSubmitted: (_) => data.form.valid ? login() : null,
                    ),
                    ReactiveLoginFormFormConsumer(
                      builder: (_, __, ___) {
                        return ElevatedButton(
                          onPressed: login,
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
      ),
    );
  }
}
