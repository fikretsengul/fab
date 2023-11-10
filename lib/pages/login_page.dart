import 'package:auth/auth.dart';
import 'package:deps/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:locator/locator.dart';
import 'package:routing/application.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<LoginBloc>(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login Page'),
              ElevatedButton(
                onPressed: () {
                  context.logger.log('naber');
                  di<LoginBloc>().login(
                    username: 'test',
                    password: 'test',
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
