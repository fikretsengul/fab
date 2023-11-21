import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/json_theme.dart';
import 'package:flutter/material.dart';

class JsonTextThemeSerializer implements JsonConverter<TextTheme, Map<String, dynamic>> {
  const JsonTextThemeSerializer();

  @override
  TextTheme fromJson(Map<String, dynamic> json) {
    return ThemeDecoder.decodeTextTheme(json, validate: false) ?? const TextTheme();
  }

  @override
  Map<String, dynamic> toJson(TextTheme theme) {
    return ThemeEncoder.encodeTextTheme(theme) ?? {};
  }
}
