// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/analytics.dart';
import 'package:deps/infrastructure/networking.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/injectable.dart';

import '../models/user.model.dart';

part 'logout.cubit.freezed.dart';
part 'states/logout.state.dart';

/// `LogoutCubit` is a Bloc class that manages the login process.
/// It listens to login requests and emits states corresponding to different stages of the login process.
@injectable
class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._dioTokenRefresh) : super(const LogoutStateInitial());

  final DioTokenRefresh _dioTokenRefresh;

  Future<void> logout() async {
    await _dioTokenRefresh.interceptor.clearToken();
  }
}
