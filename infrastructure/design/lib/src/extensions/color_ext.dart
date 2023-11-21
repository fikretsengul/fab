import 'dart:ui';

extension ColorExt on Color {
  Color get toARGB => Color.fromARGB(0, red, green, blue);
  String get toHex => "#${(value.toRadixString(16))..padLeft(8, '0').toUpperCase()}";
}
