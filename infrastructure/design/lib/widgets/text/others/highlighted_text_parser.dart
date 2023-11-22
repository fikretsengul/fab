import 'package:flutter/material.dart';

import '../highlighted_text_painter.dart';
import 'highlighted_text_style.dart';

class TextParser {
  static List<InlineSpan> parseText({
    required String text,
    required TextStyle style,
    required Map<String, HighlightedTextStyle> tags,
  }) {
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

    return children;
  }
}
