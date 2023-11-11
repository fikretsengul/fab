import 'package:deps/core/commons/errors.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../model/user.module.dart';
import '../service/auth.service.dart';

part 'login.bloc.freezed.dart';
part 'state/login.state.dart';

@lazySingleton
class LoginBloc extends Cubit<LoginState> {
  LoginBloc(this._service) : super(const LoginInitial());

  final AuthService _service;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const LoginLoading());

    final response = await _service.login(username, password);

    await Future<void>.delayed(const Duration(seconds: 2));

    response.fold(
      (failure) => emit(LoginFailed(failure)),
      (user) => emit(LoginSucceded(user)),
    );
  }
}
