// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../cubits/login.cubit.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({required this.onResult, super.key});

  final Function(bool) onResult;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<LoginBloc>(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final didLogin = await di<LoginBloc>().login(
                    username: 'test',
                    password: 'test',
                  );

                  onResult(didLogin);
                },
                child: Text(context.tr.auth.loginButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
