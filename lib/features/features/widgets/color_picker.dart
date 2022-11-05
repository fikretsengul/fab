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

final PageController pageController = PageController();

class FastColorPicker extends StatelessWidget {
  const FastColorPicker({
    super.key,
    this.icon,
    this.iconColor,
    this.disabled = false,
    this.selectedColor = Colors.white,
    required this.onColorSelected,
  });

  final Color selectedColor;
  final IconData? icon;
  final Color? iconColor;
  final bool disabled;
  final void Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectedColor(
          icon: icon,
          iconColor: iconColor,
          selectedColor: selectedColor,
        ),
        const SizedBox(width: 6),
        Opacity(
          opacity: disabled ? 0.2 : 1,
          child: Row(
            children: createColors(colors1),
          ),
        ),
      ],
    );
  }

  List<Widget> createColors(List<Color> colors) {
    return [
      for (var c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
              ),
            ),
          ),
          onTap: !disabled ? () => onColorSelected.call(c) : null,
          useCache: false,
          scaleCoefficient: 0.9,
        ),
    ];
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
