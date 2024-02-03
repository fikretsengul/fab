// ignore_for_file: max_lines_for_file, max_lines_for_function
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

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

/*   void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => ,
    );
  } */

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (_, state) {
        state.whenOrNull(
          loading: () => $.overlay.showLoadingOverlay(
            child: Center(
              child: CupertinoActivityIndicator(
                radius: 30,
                color: CupertinoTheme.of(context).primaryContrastingColor,
              ),
            ),
          ),
          failed: (failure) {
            $.overlay.hideOverlay();
            $.toast.showAlert(failure: failure);
          },
          succeeded: (user) {
            $.overlay.hideOverlay();
            $.get<UserCubit>().loggedIn(user);
          },
        );
      },
      child: FabScaffold(
        shouldStretch: false,
        appBar: FabAppBarSettings(
          searchBar: FabAppBarSearchBarSettings(),
          largeTitle: FabAppBarLargeTitleSettings(
            largeTitle: 'Login',
          ),
        ),
        children: [
          LoginFormFormBuilder(
            model: LoginForm.empty(),
            builder: (_, data, __) {
              return SliverFillRemaining(
                child: PaddingAll.md(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoTextfield(
                        formControl: data.emailControl,
                        keyboardType: TextInputType.emailAddress,
                        labelText: $.tr.auth.loginForm.email,
                        textInputAction: TextInputAction.next,
                        onSubmitted: () => data.passwordControl.focus(),
                      ),
                      PaddingGap.sm(),
                      CupertinoTextfield(
                        formControl: data.passwordControl,
                        keyboardType: TextInputType.text,
                        labelText: $.tr.auth.loginForm.password,
                        textInputAction: TextInputAction.send,
                        obscureText: true,
                        onSubmitted: () => data.form.valid
                            ? login(
                                email: data.emailControl.value ?? '',
                                password: data.passwordControl.value ?? '',
                              )
                            : null,
                      ),
                      PaddingGap.xl(),
                      ReactiveLoginFormFormConsumer(
                        builder: (_, __, ___) {
                          return CupertinoButton.filled(
                            onPressed: data.form.valid
                                ? () => login(
                                      email: data.emailControl.value ?? '',
                                      password: data.passwordControl.value ?? '',
                                    )
                                : null,
                            child: Text($.tr.auth.loginForm.loginButton),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
