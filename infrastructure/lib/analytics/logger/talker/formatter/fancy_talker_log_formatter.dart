import 'package:deps/packages/talker_flutter.dart';

class FancyTalkerLogFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final maxLineWidth = settings.maxLineWidth;
    final maxContentWidth = maxLineWidth - 4; // Adjusting for the border characters and padding

    // Define labels that shouldn't have the prefix.
    const noPrefixLabels = ['•', '«'];

    final coloredLines = msg
        .split('\n')
        .expand(
          (line) => _wrapLine(
            line,
            maxContentWidth,
            prefix: ' ' * 16,
            noPrefixKeywords: noPrefixLabels,
          ),
        ) // Adjust the prefix as needed
        .map((line) {
      // Calculate the number of spaces needed to right-align the border.
      final paddingSize = maxContentWidth - line.length; // remaining space for padding
      final padding = ' ' * (paddingSize > 0 ? paddingSize : 0); // add padding or none if negative

      // Construct the formatted line with the right-aligned border.
      return details.pen.write(
        '│ $line$padding │',
      );
    }).toList();

    // Construct the full message with top and bottom borders
    final topBorder = details.pen.write('┌${'─' * (maxLineWidth - 2)}┐\n');
    // Ensure a newline before the bottom border
    final bottomBorder = details.pen.write('\n└${'─' * (maxLineWidth - 2)}┘');

    return topBorder + coloredLines.join('\n') + bottomBorder;
  }

  // Handle long lines that need to be wrapped and aligned
  Iterable<String> _wrapLine(
    String text,
    int maxContentWidth, {
    String prefix = '',
    List<String> noPrefixKeywords = const [],
  }) {
    final wrappedLines = <String>[];
    var currentLine = text.replaceAll('\t', '    '); // Replace tabs with 4 spaces

    while (currentLine.isNotEmpty) {
      var currentMaxWidth = maxContentWidth;

      // Determine if the current line starts with one of the no-prefix keywords.
      final startsWithKeyword = noPrefixKeywords.any((keyword) => currentLine.startsWith(keyword));

      // If this isn't the first line or it doesn't start with a keyword (i.e., it's a wrapped line or doesn't have specific keywords), adjust the max width.
      if (wrappedLines.isNotEmpty || !startsWithKeyword) {
        currentMaxWidth -= prefix.length;
      }

      var cutPoint = currentLine.length > currentMaxWidth ? currentMaxWidth : currentLine.length;

      // If the line is longer than currentMaxWidth and there's a space, break at the last space
      if (cutPoint < currentLine.length) {
        final lastSpace = currentLine.substring(0, cutPoint).lastIndexOf(' ');
        if (lastSpace > -1) {
          cutPoint = lastSpace;
        }
      }

      // Add the current line segment to the wrapped lines, with the prefix if it's a continuation line or doesn't start with a keyword
      wrappedLines
          .add(((wrappedLines.isEmpty && startsWithKeyword) ? '' : prefix) + currentLine.substring(0, cutPoint));
      currentLine = currentLine.substring(cutPoint).trim(); // Update the local variable
    }

    return wrappedLines;
  }
}
