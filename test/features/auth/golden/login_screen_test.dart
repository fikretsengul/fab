import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_advanced_boilerplate/features/auth/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/auth/form/login_form.dart';
import 'package:flutter_advanced_boilerplate/features/auth/presentation/login_screen.dart';

import '../../../utils/golden_utils.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  const description = 'Login Screen';
  final cubit = MockAuthCubit();
  final form = loginForm;

  screenshotTest(
    description,
    variantName: 'on Initial',
    setUp: () {
      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.initial()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit),
  );

  screenshotTest(
    description,
    variantName: 'on Validation Fail',
    setUp: () {
      form.markAllAsTouched();

      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.initial()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit, form: form),
  );

  screenshotTest(
    description,
    variantName: 'on Validation Success',
    setUp: () {
      form.control('username').value = 'test_username';
      form.control('password').value = 'test_password';

      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.initial()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit, form: form),
  );

  screenshotTest(
    description,
    variantName: 'on Loading',
    setUp: () {
      form.control('username').value = 'test_username';
      form.control('password').value = 'test_password';

      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.loading()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit, form: form),
  );

  screenshotTest(
    description,
    variantName: 'on Success',
    setUp: () {
      form.control('username').value = 'test_username';
      form.control('password').value = 'test_password';

      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.success()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit, form: form),
  );

  screenshotTest(
    description,
    variantName: 'on Fail',
    setUp: () {
      form.control('username').value = 'test_username';
      form.control('password').value = 'test_password';

      whenListen(
        cubit,
        Stream.fromIterable(
          const [AuthState.fail()],
        ),
        initialState: const AuthState.initial(),
      );
    },
    screen: LoginScreen(cubit: cubit, form: form),
  );
}
