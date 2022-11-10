import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.controller,
    required this.text,
    this.onPressed,
    this.resetAfterDuration = false,
    this.animateOnTap = false,
    this.width = 300,
    this.height = 60,
  });

  final RoundedLoadingButtonController controller;
  final String text;
  final void Function()? onPressed;
  final bool resetAfterDuration;
  final bool animateOnTap;
  final double width;
  final double height;

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
