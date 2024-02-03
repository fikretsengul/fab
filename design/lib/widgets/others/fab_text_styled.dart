import 'package:deps/features/features.dart';
import 'package:deps/packages/styled_text.dart';
import 'package:flutter/widgets.dart';

/// This widget is mainly a modification for StyledText
/// widget. It translates with the translation key and escapes some
/// characters that create problems for StyledText.
class FabTextStyled extends StatelessWidget {
  const FabTextStyled({
    required this.text,
    this.tags,
    this.style,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final int? maxLines;
  final TextOverflow overflow;
  final TextStyle? style;
  final Map<String, StyledTextTagBase>? tags;
  final String text;
  final TextAlign textAlign;

  Map<String, StyledTextTagBase> parseTags() {
    if (style == null) {
      return {};
    }

    return {
      'b': StyledTextTag(
        style: style?.bold,
      ),
      'i': StyledTextTag(
        style: style?.italic,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text,
      style: style,
      tags: {...parseTags(), ...tags ?? {}},
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
