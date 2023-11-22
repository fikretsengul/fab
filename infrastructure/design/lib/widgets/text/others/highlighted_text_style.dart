import 'package:flutter/material.dart';

/// Holds the style information for highlighted text.
class HighlightedTextStyle {
  /// Constructs an instance of [HighlightedTextStyle].
  ///
  /// [style] specifies the text style for the highlighted text.
  /// [highlightColor] specifies the background color for the highlight effect.
  /// [offset] specifies the x and y offset of the highlight from the text.
  /// [limitOffsetToWordSize] if true, limits the offset background size to the size of the word.
  HighlightedTextStyle({
    required this.style,
    required this.highlightColor,
    this.offset = const Offset(7, 7),
    this.limitOffsetToWordSize = true,
  });

  final TextStyle style;
  final Color highlightColor;
  final Offset offset;
  final bool limitOffsetToWordSize;
}
