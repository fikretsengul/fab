import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.controller,
    required this.text,
    super.key,
    this.onPressed,
    this.resetAfterDuration = false,
    this.animateOnTap = false,
    this.width = 300,
    this.height = 60,
  });

  final void Function()? onPressed;
  final bool animateOnTap;
  final RoundedLoadingButtonController controller;
  final double height;
  final bool resetAfterDuration;
  final String text;
  final double width;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      elevation: $constants.theme.defaultElevation,
      width: widget.width,
      height: widget.height,
      color: widget.onPressed != null ? getCustomOnPrimaryColor(context) : getPrimaryColor(context),
      controller: widget.controller,
      onPressed: widget.onPressed,
      valueColor: getTheme(context).primary,
      resetAfterDuration: widget.resetAfterDuration,
      animateOnTap: widget.animateOnTap,
      child: AutoSizeText(
        widget.text,
        style: getTextTheme(context).titleMedium!.apply(color: Colors.white),
      ),
    );
  }
}
