/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helpers.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({
    required this.onCancel,
    required this.cancelButtonText,
    required this.cancelButtonTextStyle,
    required this.animationDuration,
    required this.searchBarHasFocus,
    super.key,
  });

  final Duration animationDuration;
  final String cancelButtonText;
  final TextStyle cancelButtonTextStyle;
  final Function() onCancel;
  final bool searchBarHasFocus;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      onPressed: onCancel,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: searchBarHasFocus ? 1 : 0,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            cancelButtonText,
            style: cancelButtonTextStyle,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
 */