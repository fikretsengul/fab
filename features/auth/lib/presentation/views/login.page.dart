// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../domain/forms/login.form.dart';
import '../cubits/login.cubit.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({required this.onResult, super.key});

  final Function(bool didLogin) onResult;

  Future<void> login() async {
    final isSucceeded = await di<LoginCubit>().login(
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
      create: (_) => di<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (_, state) {
          state.whenOrNull(
            //failed: (failure) => showAlertDialog(context, failure),
            succeeded: (user) => di<UserCubit>().loggedIn(user),
          );
        },
        child: Scaffold(
          body: LoginFormFormBuilder(
            model: LoginForm.empty(),
            builder: (context, data, _) {
              return PaddingAll.md(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FabReactiveTextfield(
                      formControl: data.emailControl,
                      keyboardType: TextInputType.emailAddress,
                      labelText: context.tr.loginForm.email,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => data.passwordControl.focus(),
                    ),
                    PaddingGap.xs(),
                    FabReactiveTextfield(
                      formControl: data.passwordControl,
                      keyboardType: TextInputType.text,
                      labelText: context.tr.loginForm.password,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => data.form.valid ? login() : null,
                    ),
                    ReactiveLoginFormFormConsumer(
                      builder: (context, _, __) {
                        return ElevatedButton(
                          onPressed: login,
                          child: Text(context.tr.loginForm.loginButton),
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
