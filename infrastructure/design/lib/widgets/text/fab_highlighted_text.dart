import 'package:flutter/material.dart';

import 'others/highlighted_text_parser.dart';
import 'others/highlighted_text_style.dart';

/// A widget that displays text with parts highlighted based on specified tags.
class FabHighlightedText extends StatelessWidget {
  /// Constructs an instance of [FabHighlightedText].
  ///
  /// [text] is the string that contains the text and tags to be highlighted.
  /// [style] is the default text style for the text that is not highlighted.
  /// [tags] is a map of tag names to their corresponding [HighlightedTextStyle].
  const FabHighlightedText({
    required this.text,
    required this.style,
    required this.tags,
    super.key,
  });

  final String text;
  final TextStyle style;
  final Map<String, HighlightedTextStyle> tags;

  @override
  Widget build(BuildContext context) {
    final children = TextParser.parseText(text: text, style: style, tags: tags);

    // Combine all spans into a RichText widget.
    return Text.rich(
      TextSpan(children: children),
    );
  }
}
