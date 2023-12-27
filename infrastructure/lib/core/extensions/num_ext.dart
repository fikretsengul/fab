// https://github.com/nank1ro/awesome_flutter_extensions

extension IntExt on int {
  /// Converts an integer to its English ordinal representation.
  /// For example, 1 becomes "1st", 2 becomes "2nd", 3 becomes "3rd", and so forth.
  String get ordinal {
    return switch (this % 100) {
      11 || 12 || 13 => '${this}th',
      _ => switch (this % 10) { 1 => '${this}st', 2 => '${this}nd', 3 => '${this}rd', _ => '${this}th' }
    };
  }

  /// Converts an integer to its Roman numeral representation.
  /// Works for numbers from 1 to 3999.
  ///
  /// Throws an `Exception` if the number is out of this range.
  String get roman {
    if (this < 1 || this > 3999) {
      throw Exception('Number out of range (1 to 3999)');
    }

    const romanTable = {
      'M': 1000,
      'CM': 900,
      'D': 500,
      'CD': 400,
      'C': 100,
      'XC': 90,
      'L': 50,
      'XL': 40,
      'X': 10,
      'IX': 9,
      'V': 5,
      'IV': 4,
      'I': 1,
    };

    final result = StringBuffer();
    var n = this;
    for (final entry in romanTable.entries) {
      final numeral = entry.key;
      final value = entry.value;
      while (n >= value) {
        result.write(numeral);
        n -= value;
      }
    }

    return result.toString();
  }
}
