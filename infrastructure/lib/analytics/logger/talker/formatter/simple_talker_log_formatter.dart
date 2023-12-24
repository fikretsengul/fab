import 'package:deps/packages/talker_flutter.dart';

class SimpleTalkerLogFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final maxLineWidth = settings.maxLineWidth;

    final coloredLines = msg
        .split('\n')
        .expand((line) => _wrapLine(line, maxLineWidth)) // Handle long lines
        .map((line) {
      // Calculate the number of spaces needed to right-align the border.
      final paddingSize = maxLineWidth - line.length; // remaining space for padding
      final padding = ' ' * (paddingSize > 0 ? paddingSize : 0); // add padding or none if negative

      // Construct the formatted line with the right-aligned border.
      return details.pen.write(
        '$line$padding',
      );
    }).toList();

    // Construct the full message with top and bottom borders
    final topBorder = details.pen.write('${'*' * maxLineWidth}\n');
    // Ensure a newline before the bottom border
    final bottomBorder = details.pen.write('\n${'*' * maxLineWidth}');
    final coloredMsg = topBorder + coloredLines.join('\n') + bottomBorder;

    return coloredMsg;
  }

  // Handle long lines that need to be wrapped
  Iterable<String> _wrapLine(String text, int maxContentWidth) {
    final wrappedLines = <String>[];
    var currentLine = text.replaceAll('\t', '    '); // Replace tabs with 4 spaces
    // Adjust if your environment uses a different number of spaces per tab

    while (currentLine.isNotEmpty) {
      final cutPoint = currentLine.length > maxContentWidth ? maxContentWidth : currentLine.length;

      wrappedLines.add(currentLine.substring(0, cutPoint));
      currentLine = currentLine.substring(cutPoint).trim(); // Update the local variable
    }
    return wrappedLines;
  }
}
