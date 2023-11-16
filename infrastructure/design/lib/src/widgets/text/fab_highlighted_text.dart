import 'package:flutter/material.dart';

import 'highlighted_text_painter.dart';

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
    final children = <InlineSpan>[];
    var lastMatchEnd = 0;

    // Iterate over each tag to apply styles and highlight effects.
    tags.forEach((tag, tagStyle) {
      final tagPattern = RegExp('<$tag>(.*?)</$tag>');

      // Match the tag pattern in the text and style each match.
      tagPattern.allMatches(text).forEach((match) {
        final startIndex = match.start;
        final endIndex = match.end;
        final taggedText = match.group(1)!;

        // Add text before the tag as a normal text span.
        if (startIndex > lastMatchEnd) {
          children.add(
            WidgetSpan(
              child: Text(
                text.substring(lastMatchEnd, startIndex),
                style: style,
              ),
            ),
          );
        }

        // Add the tagged text with a background highlight.
        children.add(
          WidgetSpan(
            child: Stack(
              children: <Widget>[
                // If offset limiting is enabled, use a SizedBox to constrain the size of the highlight.
                if (tagStyle.limitOffsetToWordSize)
                  Positioned(
                    left: tagStyle.offset.dx,
                    top: tagStyle.offset.dy,
                    child: CustomPaint(
                      painter: HighlightedTextPainter(
                        text: taggedText,
                        textStyle: tagStyle.style,
                        backgroundColor: tagStyle.highlightColor,
                        offset: Offset.zero,
                      ),
                      child: tagStyle.limitOffsetToWordSize
                          ? SizedBox(
                              width: tagStyle.style.fontSize! * taggedText.length,
                              height: tagStyle.style.fontSize,
                            )
                          : null,
                    ),
                  ),
                // Display the highlighted text itself.
                Text(taggedText, style: tagStyle.style),
              ],
            ),
          ),
        );

        lastMatchEnd = endIndex;
      });
    });

    // Add any remaining text after the last tag.
    if (lastMatchEnd < text.length) {
      children.add(
        WidgetSpan(
          child: Text(
            text.substring(lastMatchEnd),
            style: style,
          ),
        ),
      );
    }

    // Combine all spans into a RichText widget.
    return Text.rich(TextSpan(children: children));
  }
}
