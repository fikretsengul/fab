extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((e) => e.capitalize()).join(' ');
  }

  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  bool isNumericOnly() => hasMatch(r'^\d+$');

  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  bool hasCapitalletter() => hasMatch('[A-Z]');

  bool isBool() {
    return this == 'true' || this == 'false';
  }
}
