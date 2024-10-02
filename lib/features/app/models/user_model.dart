import 'package:flutter_advanced_boilerplate/assets.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String? id,
    required String? username,
    required String? email,
    required String? profileImageUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.initial() => UserModel(
        id: '123456789',
        username: 'محمد',
        email: 'testo@email.com',
        profileImageUrl: Images.defaultProfilePicture.assetName,
      );
}
