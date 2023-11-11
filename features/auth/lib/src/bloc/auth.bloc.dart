import 'package:deps/core/commons/enums.dart';
import 'package:deps/core/networking/networking.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

part 'auth.bloc.freezed.dart';
part 'state/auth.state.dart';

@lazySingleton
class AuthBloc extends Cubit<AuthState> {
  AuthBloc(this._dioTokenRefresh) : super(const AuthLoading()) {
    _dioTokenRefresh.interceptor.authStatus.listen(
      (status) async {
        if (status == AuthStatus.authenticated) {
          emit(const AuthAuthenticated());
        } else if (status == AuthStatus.unauthenticated) {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  final DioTokenRefresh _dioTokenRefresh;
}
