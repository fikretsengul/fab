import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonColorTypeSerializer implements JsonConverter<Color, int> {
  const JsonColorTypeSerializer();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}
