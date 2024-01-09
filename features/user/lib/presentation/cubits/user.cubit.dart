// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';

import '../../domain/models/user.model.dart';

@lazySingleton
class UserCubit extends HydratedCubit<UserModel> {
  UserCubit(this._client) : super(UserModel.empty());

  final INetworkClient _client;

  void loggedIn(UserModel user) {
    emit(user);
  }

  Future<void> logout() async {
    await _client.tokenStorage.clearToken();
    emit(UserModel.empty());
  }

  @override
  UserModel? fromJson(Map<String, dynamic> json) {
    try {
      return UserModel.fromJson(json);
    } catch (_) {
      return UserModel.empty();
    }
  }

  @override
  Map<String, dynamic>? toJson(UserModel state) {
    return state.toJson();
  }
}
