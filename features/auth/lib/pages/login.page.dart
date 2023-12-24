// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/analytics.dart';
import 'package:deps/infrastructure/commons.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../cubits/login.cubit.dart';
import '../forms/login.form.dart';
import '../i18n/translations.g.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({required this.onResult, super.key});

  final Function(bool) onResult;

  Future<void> login() async {
    final didLogin = await di<LoginCubit>().login(
      email: 'test',
      password: 'test',
    );

    if (didLogin) {
      onResult(true);
    }
  }

  void showAlertDialog(BuildContext context, IFailure failure) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(failure.message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (_, state) {
          logger.log(state);
          state.whenOrNull(
            failed: (failure) => showAlertDialog(context, failure),
            succeeded: (user) => di<UserCubit>().loggedIn(user),
          );
        },
        child: Scaffold(
          body: LoginFormFormBuilder(
            model: LoginForm.empty(),
            builder: (context, data, child) {
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
                      builder: (context, data, child) {
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
