import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/palette.dart';
import 'package:spring_button/spring_button.dart';

const List<Color> colors1 = [
  Palette.red,
  Palette.orange,
  Palette.yellow,
  Palette.green,
  Palette.cyan,
  Palette.blue,
  Palette.purple,
  Palette.magenta,
];

final Map<int, double> _correctSizes = {};
final PageController pageController = PageController();

class FastColorPicker extends StatelessWidget {
  const FastColorPicker({
    super.key,
    this.icon,
    this.iconColor,
    this.selectedColor = Colors.white,
    required this.onColorSelected,
  });

  final Color selectedColor;
  final IconData? icon;
  final Color? iconColor;
  final void Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: SelectedColor(
              icon: icon,
              iconColor: iconColor,
              selectedColor: selectedColor,
            ),
          ),
          Row(
            children: createColors(context, colors1),
          ),
        ],
      ),
    );
  }

  List<Widget> createColors(BuildContext context, List<Color> colors) {
    final size = _correctSizes[colors.length] ??
        correctButtonSize(
          colors.length,
          MediaQuery.of(context).size.width - 32,
        );

    return [
      for (var c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: EdgeInsets.all(size * 0.1),
            child: AnimatedContainer(
              width: size,
              height: size,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
/*                 border: Border.all(
                  width: c == selectedColor ? 4 : 2,
                  color: Colors.white,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: size * 0.1,
                    color: Colors.black12,
                  ),
                ], */
              ),
            ),
          ),
          onTap: () {
            onColorSelected.call(c);
          },
          useCache: false,
          scaleCoefficient: 0.9,
        ),
    ];
  }

  double correctButtonSize(int itemSize, double screenWidth) {
    const firstSize = 52;
    final maxWidth = screenWidth - firstSize;
    var isSizeOkay = false;
    var finalSize = 48;
    do {
      finalSize -= 2;
      final eachSize = finalSize * 1.2;
      final buttonsArea = itemSize * eachSize;
      isSizeOkay = maxWidth > buttonsArea;
    } while (!isSizeOkay);
    _correctSizes[itemSize] = finalSize.toDouble();

    return finalSize.toDouble();
  }
}

class SelectedColor extends StatelessWidget {
  const SelectedColor({super.key, required this.selectedColor, this.icon, this.iconColor});
  final Color selectedColor;
  final IconData? icon;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: selectedColor,
        shape: BoxShape.circle,
/*         border: const Border.fromBorderSide(BorderSide(width: 2, color: Colors.white)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black38,
          ),
        ], */
      ),
      child: icon != null
          ? Icon(
              icon,
              color: iconColor,
              size: 22,
            )
          : null,
    );
  }
}
