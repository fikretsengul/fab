// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/widgets.dart';

/// `JsonColorTypeSerializer` is a converter class used for serializing and deserializing
/// `Color` objects to and from JSON. It implements the `JsonConverter` interface,
/// providing custom logic to handle `Color` objects in JSON operations.
class JsonColorTypeSerializer implements JsonConverter<Color, int> {
  /// Constructs a `JsonColorTypeSerializer`.
  const JsonColorTypeSerializer();

  /// Converts an integer from JSON to a `Color` object.
  ///
  /// [json]: The integer value representing a color, typically in ARGB format.
  ///
  /// Returns a `Color` object corresponding to the provided integer value.
  @override
  Color fromJson(int json) => Color(json);

  /// Converts a `Color` object to an integer for JSON serialization.
  ///
  /// [color]: The `Color` object to serialize.
  ///
  /// Returns an integer representation of the color, suitable for JSON serialization.
  @override
  int toJson(Color color) => color.value;
}
