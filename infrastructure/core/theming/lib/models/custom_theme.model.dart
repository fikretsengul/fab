// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/json_theme.dart';
import 'package:flutter/material.dart';

part 'custom_theme.model.freezed.dart';

@freezed
class CustomTheme with _$CustomTheme {
  factory CustomTheme({
    required ThemeMode mode,
    required Brightness brightness,
    required ThemeData data,
  }) = _CustomTheme;

  CustomTheme._();

  factory CustomTheme.inital() => CustomTheme(
        mode: ThemeMode.light,
        brightness: Brightness.light,
        data: ThemeData.light(),
      );

  factory CustomTheme.fromJson(Map<String, dynamic> json) {
    try {
      final mode = json['mode'] as int;
      final brightness = json['brightness'] as int;
      final data = json['data'] as Map<String, dynamic>;

      return CustomTheme(
        mode: ThemeMode.values.elementAt(mode),
        brightness: Brightness.values.elementAt(brightness),
        data: ThemeDecoder.decodeThemeData(data, validate: false)!,
      );
    } catch (e) {
      return CustomTheme.inital();
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mode': mode.index,
      'brightness': brightness.index,
      'data': ThemeEncoder.encodeThemeData(data),
    };
  }
}
