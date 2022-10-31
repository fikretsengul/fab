import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  Future<void> login({required String username, required String password}) async {
    emit(const AuthState.loading());

    final isIdPwCorrect = username == 'test' && password == 'test';

    await Future.delayed(
      const Duration(seconds: 2),
      () => emit(
        isIdPwCorrect ? const AuthState.success() : const AuthState.fail(),
      ),
    );
  }

  @visibleForTesting
  Future<void> changeState(AuthState state) {
    emit(state);

    return Future.delayed(const Duration(seconds: 2));
  }
}
