// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// Extension on `TextStyle` to provide convenient methods for modifying text style properties.
extension TextStyleExt on TextStyle {
  /// Returns a copy of the current `TextStyle` with maximum thickness (w900).
  TextStyle get mostThick => copyWith(fontWeight: FontWeight.w900);

  /// Returns a copy of the current `TextStyle` with extra bold weight (w800).
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  /// Returns a copy of the current `TextStyle` with bold weight (w700).
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Returns a copy of the current `TextStyle` with semi-bold weight (w600).
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Returns a copy of the current `TextStyle` with medium weight (w500).
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Returns a copy of the current `TextStyle` with regular weight (w400).
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Returns a copy of the current `TextStyle` with light weight (w300).
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Returns a copy of the current `TextStyle` with extra light weight (w200).
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  /// Returns a copy of the current `TextStyle` with thin weight (w100).
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  /// Returns a copy of the current `TextStyle` in italic style.
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Returns a copy of the current `TextStyle` with an underline decoration.
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  /// Returns a copy of the current `TextStyle` with a modified font size.
  TextStyle changeSize(double size) => copyWith(fontSize: size);

  /// Returns a copy of the current `TextStyle` with a modified font family.
  TextStyle changeFamily(String family) => copyWith(fontFamily: family);

  /// Returns a copy of the current `TextStyle` with a modified letter spacing.
  TextStyle changeLetterSpacing(double space) => copyWith(letterSpacing: space);

  /// Returns a copy of the current `TextStyle` with a modified word spacing.
  TextStyle changeWordSpacing(double space) => copyWith(wordSpacing: space);

  /// Returns a copy of the current `TextStyle` with a modified color.
  TextStyle changeColor(Color color) => copyWith(color: color);

  /// Returns a copy of the current `TextStyle` with a modified text baseline.
  TextStyle changeBaseline(TextBaseline textBaseline) => copyWith(textBaseline: textBaseline);
}
