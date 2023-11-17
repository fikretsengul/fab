import 'package:flutter/foundation.dart';

@immutable
final class Durations {
  /// Just to delay with 50 milliseconds.
  static const delay = Duration(milliseconds: 50);

  /// 300 milliseconds.
  static const fast = Duration(milliseconds: 300);

  /// 500 milliseconds.
  static const medium = Duration(milliseconds: 500);

  /// 750 milliseconds.
  static const slow = Duration(milliseconds: 750);

  /// 150 milliseconds.
  static const xFast = Duration(milliseconds: 150);

  /// 900 milliseconds.
  static const xSlow = Duration(milliseconds: 900);
}
