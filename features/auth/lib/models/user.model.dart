// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

/// `User` is an immutable class representing a user entity in your application.
/// It leverages the `freezed` package for immutability and provides methods for
/// JSON serialization and deserialization.
@freezed
class User with _$User {
  /// Constructs a `User` instance with the required details.
  ///
  /// [id]: The unique identifier of the user.
  /// [username]: The username of the user.
  /// [email]: The email address of the user.
  const factory User({
    required String id,
    required String username,
    required String email,
  }) = _User;

  /// Creates an empty `User` instance with default values.
  /// Useful for initializing a user object in a null-safe way.
  factory User.empty() => const User(
        id: '',
        username: '',
        email: '',
      );

  /// Factory method to create a `User` instance from JSON data.
  ///
  /// [json]: The JSON map to be converted into a `User` instance.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
