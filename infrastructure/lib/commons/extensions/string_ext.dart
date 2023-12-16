// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

extension StringExtension on String {
  /// Capitalizes each word in a string.
  ///
  /// Splits the string by spaces and capitalizes the first letter of each word.
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((e) => e.capitalizeFirst()).join(' ');
  }

  /// Capitalizes the first letter of the string.
  ///
  /// If the string is empty, returns the original string.
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Removes all whitespace from the string.
  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  /// Checks if the string matches the given pattern.
  ///
  /// [pattern]: The regex pattern to match against.
  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  /// Checks if the string contains only numeric characters.
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// Checks if the string contains only alphabetic characters.
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if the string contains at least one capital letter.
  bool hasCapitalletter() => hasMatch('[A-Z]');

  /// Checks if the string is a boolean representation.
  ///
  /// Returns `true` if the string is 'true' or 'false'.
  bool isBool() {
    return this == 'true' || this == 'false';
  }
}
