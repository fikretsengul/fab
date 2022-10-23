import 'package:flutter_advanced_boilerplate/features/app/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String tokenType,
    required String accessToken,
    required String refreshToken,
    required UserModel user,
  }) = _AuthModel;

  factory AuthModel.initial() => AuthModel(
        tokenType: '',
        accessToken: '',
        refreshToken: '',
        user: UserModel.initial(),
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
}
