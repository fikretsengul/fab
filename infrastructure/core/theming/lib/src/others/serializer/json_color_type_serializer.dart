import 'package:deps/packages/freezed_annotation.dart';
import 'package:flutter/widgets.dart';

class JsonColorTypeSerializer implements JsonConverter<Color, int> {
  const JsonColorTypeSerializer();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}
