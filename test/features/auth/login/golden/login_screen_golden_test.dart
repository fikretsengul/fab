import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/form/login_form.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/presentation/login_screen.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../utils/golden_utils.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  final cubit = MockAuthCubit();
  final form = loginForm;

  group('Login Golden Test', () {
    setUpAll(() async {
      await configureDependencyInjection();
    });

    screenshotTest<MockAuthCubit, AuthState>(
      'Initial',
      cubit: cubit,
      initialState: const AuthState.unauthenticated(),
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );

    screenshotTest<MockAuthCubit, AuthState>(
      'Validation Fail',
      cubit: cubit,
      initialState: const AuthState.unauthenticated(),
      form: form,
      formAction: (form) {
        form.markAllAsTouched();
      },
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );

    screenshotTest<MockAuthCubit, AuthState>(
      'Validation Success',
      cubit: cubit,
      initialState: const AuthState.unauthenticated(),
      form: form,
      formAction: (form) {
        form.control('username').value = 'test_username';
        form.control('password').value = 'test_password';
      },
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );

    screenshotTest<MockAuthCubit, AuthState>(
      'Loading',
      cubit: cubit,
      initialState: const AuthState.loading(),
      form: form,
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );

    screenshotTest<MockAuthCubit, AuthState>(
      'Fail',
      cubit: cubit,
      initialState: const AuthState.loading(),
      finalState: AuthState.failed(
        alert: AlertModel.alert(
          message: t.core.test.failed,
          type: AlertType.destructive,
        ),
      ),
      form: form,
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );

    screenshotTest<MockAuthCubit, AuthState>(
      'Success',
      cubit: cubit,
      initialState: const AuthState.loading(),
      finalState: AuthState.authenticated(user: UserModel.initial()),
      form: form,
      screen: (cubit, form) => LoginScreen(cubit: cubit, form: form),
    );
  });
}
