import 'package:deps/design/design.dart';
import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/go_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FabAppBar(title: 'Home'),
      body: DottedBackground(
        shape: DotsShape.texture,
        child: RandomSvgBackground(
          count: 5,
          child: Column(
            children: [
              Paddings.sm.vertical,
              FabTextButton(
                onPressed: () => context.go('/fonts'),
                text: 'Check Fonts',
                textStyle: context.bodyMedium!.copyWith(
                  fontFamily: FontFamily.fogtwoNo5,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                buttonType: ButtonType.classic,
              ),
              Paddings.sm.vertical,
              Center(
                child: FabContainer(
                  padding: Paddings.sm.all,
                  child: Column(
                    children: [
                      Text(
                        'Hilalim seni çok seviyorum.',
                        style: context.titleLarge!.copyWith(
                          fontFamily: FontFamily.fogtwoNo5,
                          fontSize: 30,
                        ),
                      ),
                      /*                 Text(
                        'Hilalim seni çok seviyorum.',
                        style: context.titleLarge!.copyWith(fontFamily: FontFamily.lack),
                      ),
                      Text(
                        'Hilalim seni çok seviyorum.',
                        style: context.titleLarge!.copyWith(fontFamily: FontFamily.lackLine),
                      ), */

                      /*                 FabHighlightedText(
                        text: 'Selam <a>Hilal</a>. Benim adım <b>Fikret</b>.',
                        style: context.titleLarge!,
                        tags: {
                          'a': HighlightedTextStyle(
                            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                            highlightColor: const Color.fromARGB(255, 255, 133, 188),
                          ),
                          'b': HighlightedTextStyle(
                            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                            highlightColor: Colors.yellow,
                          ),
                        },
                      ), */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
