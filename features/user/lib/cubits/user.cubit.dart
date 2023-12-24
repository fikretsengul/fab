import 'package:deps/infrastructure/analytics.dart';
import 'package:deps/infrastructure/networking.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../models/user.model.dart';

part 'states/user.state.dart';
part 'user.cubit.freezed.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit(this._client) : super(UserState.initial());

  final INetworkClient _client;

  void loggedIn(UserModel user) {
    emit(state.copyWith(user: user));
  }

  Future<void> logout() async {
    await _client.tokenStorage.clearToken();
  }
}
