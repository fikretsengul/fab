import 'package:deps/design/design.dart';
import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBackground(
      child: Column(
        children: [
          FabTextButton(
            onPressed: () {},
            text: 'Button',
          ),
          //Paddings.sm.vertical,
          FabIconButton(
            onPressed: () {},
            icon: UIcons.boldRounded.star,
            size: 15,
          ),
          //Paddings.sm.vertical,
          FabTextButton(
            onPressed: () {},
            text: 'Button',
            buttonType: ButtonType.classic,
          ),
          //Paddings.sm.vertical,
          FabContainer(
            //padding: Paddings.sm.all,
            child: FabHighlightedText(
              text: 'Selam <a>Hilal</a>. Benim adım <b>Fikret</b>.',
              style: context.textTheme.titleLarge!,
              tags: {
                'a': HighlightedTextStyle(
                  style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  highlightColor: const Color.fromARGB(255, 255, 133, 188),
                ),
                'b': HighlightedTextStyle(
                  style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  highlightColor: Colors.yellow,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OffsetBackgroundText extends StatelessWidget {
  const OffsetBackgroundText({
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.offset,
    super.key,
  });
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OffsetBackgroundTextPainter(
        text: text,
        textStyle: textStyle,
        backgroundColor: backgroundColor,
        offset: offset,
      ),
    );
  }
}

class _OffsetBackgroundTextPainter extends CustomPainter {
  _OffsetBackgroundTextPainter({
    required this.text,
    required this.textStyle,
    required this.backgroundColor,
    required this.offset,
  });
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    final span = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    )..layout();

    // Calculate the size of the text
    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    // Paint the background with offset
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(
      Offset(offset.dx, offset.dy) & Size(textWidth, textHeight / 2),
      backgroundPaint,
    );

    // Paint the text
    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
