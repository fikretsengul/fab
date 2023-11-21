import 'package:deps/core/theming/theming.dart';
import 'package:deps/design/design.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/router.gr.dart';

@RoutePage()
class HomeRouter extends AutoRouter {
  const HomeRouter({super.key});
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DiagonalStripesBackground(
        child: Padding(
          padding: Paddings.md.all,
          child: RandomSvgBackground(
            count: 5,
            child: Column(
              children: [
                FabTextButton(
                  onPressed: () => context.navigateTo(FontsRoute()),
                  text: 'Check Fonts',
                ),
                Paddings.sm.verticalBox,
                FabTextButton(
                  onPressed: () => di<ThemeCubit>().setThemeMode(
                    mode: ThemeMode.light,
                    data: Themes.light(),
                  ),
                  text: 'Light Theme',
                  buttonType: ButtonType.classic,
                  //textStyle: ,
                ),
                Paddings.sm.verticalBox,
                FabTextButton(
                  onPressed: () => di<ThemeCubit>().setThemeMode(
                    mode: ThemeMode.dark,
                    data: Themes.dark(),
                  ),
                  text: 'Dark Theme',
                  buttonType: ButtonType.classic,
                  //textStyle: ,
                ),
                Paddings.sm.verticalBox,
                Center(
                  child: FabContainer(
                    padding: Paddings.sm.top,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
