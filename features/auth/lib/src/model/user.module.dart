import 'package:deps/packages/freezed_annotation.dart';

part 'user.module.freezed.dart';
part 'user.module.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String username,
    required String email,
  }) = _User;

  factory User.empty() => const User(
        id: '',
        username: '',
        email: '',
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
