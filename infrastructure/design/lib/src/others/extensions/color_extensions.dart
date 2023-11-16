import 'dart:ui';

extension ColorExtensions on Color {
  Color get toARGB => Color.fromARGB(0, red, green, blue);

  String get toHex => "#${(value.toRadixString(16))..padLeft(8, '0').toUpperCase()}";
}
