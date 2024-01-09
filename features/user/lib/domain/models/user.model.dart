// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

enum UserRoleEnum { customer, admin }

@freezed
sealed class UserModel with _$UserModel {
  factory UserModel({
    required int id,
    required String email,
    required UserRoleEnum role,
    required String avatar,
    @Default('') String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.empty() => UserModel(
        id: 0,
        email: '',
        role: UserRoleEnum.customer,
        avatar: '',
      );

  UserModel._();

  bool get isEmpty => this == UserModel.empty();
}
