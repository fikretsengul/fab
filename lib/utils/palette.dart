import 'package:flutter/material.dart';

@immutable
abstract class Palette {
  const Palette._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const grey = Color(0xFF9E9E9E);
  static const red = Color(0xFFFF0000);
  static const orange = Color(0xFFFF8000);
  static const yellow = Color(0xFFFCCC1A);
  static const green = Color(0xFF66B032);
  static const cyan = Color(0xFF00FFFF);
  static const blue = Color(0xFF0000FF);
  static const purple = Color(0xFF0080FF);
  static const magenta = Color(0xFFFF00FF);
}
