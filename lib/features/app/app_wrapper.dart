import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/utils/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Remove splash screen after initialization.
        FlutterNativeSplash.remove();

        state.whenOrNull(
          authenticated: (_) {
            context.router.push(const AppNavigatorRoute());
          },
          unauthenticated: () {
            context.router.replaceAll([LoginScreenRoute()]);
          },
        );
      },
      child: RepaintBoundary(
        key: _key,
        child: const AutoRouter(),
      ),
    );
  }
}
