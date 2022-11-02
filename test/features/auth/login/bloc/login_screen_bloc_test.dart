import 'package:bloc_test/bloc_test.dart';
import 'package:data_channel/data_channel.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/networking/auth_repository.dart';
import 'package:flutter_advanced_boilerplate/modules/token_refresh/dio_token_refresh.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late TokenStorage<AuthModel> storage;
  late DioTokenRefresh refresh;
  late AuthModel auth;

  setUp(() {
    repository = MockAuthRepository();
    storage = InMemoryTokenStorage<AuthModel>();
    refresh = DioTokenRefresh(storage);
    auth = AuthModel(
      tokenType: 'Bearer ',
      accessToken: 'demo_access_token',
      refreshToken: 'demo_refresh_token',
      user: UserModel.initial(),
    );
  });

  group('Login Bloc Test', () {
    blocTest<AuthCubit, AuthState>(
      'Fail',
      build: () {
        when(() => repository.login(username: '', password: '')).thenAnswer(
          (_) async => DC.error(AlertModel.quiet()),
        );

        return AuthCubit(repository, refresh);
      },
      act: (cubit) async {
        await cubit.login(username: '', password: '');
      },
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
        AuthState.failed(alert: AlertModel.quiet()),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'Authenticated',
      build: () {
        when(() => repository.login(username: any(named: 'username'), password: any(named: 'password'))).thenAnswer(
          (_) async => DC.data(auth),
        );

        return AuthCubit(repository, refresh);
      },
      act: (cubit) async {
        await cubit.login(username: '', password: '');
      },
      expect: () => [
        const AuthState.loading(),
        const AuthState.unauthenticated(),
        AuthState.authenticated(user: auth.user),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'Unauthenticated',
      build: () {
        when(
          () => repository.logout(auth: AuthModel.initial()),
        ).thenAnswer(
          (_) async => DC.data(null),
        );

        return AuthCubit(repository, refresh);
      },
      seed: () => AuthState.authenticated(user: auth.user),
      act: (cubit) async {
        await refresh.fresh.setToken(auth);
        await cubit.logOut();
      },
      expect: () => const [
        AuthState.unauthenticated(),
      ],
    );
  });
}
