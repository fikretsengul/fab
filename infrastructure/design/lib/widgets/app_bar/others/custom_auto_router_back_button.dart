import 'package:deps/packages/auto_route.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../../../design.dart';

class CustomAutoRouterBackButton extends StatelessWidget {
  const CustomAutoRouterBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoLeadingButton(
      builder: (context, leadingType, action) {
        if (leadingType == LeadingType.noLeading) {
          return const SizedBox(width: 30, height: 30);
        }

        final icon = switch (leadingType) {
          LeadingType.back => UIcons.boldRounded.angle_left,
          LeadingType.close => Icons.close,
          _ => Icons.draw_rounded,
        };

        return FabIconButton(
          icon: icon,
          buttonType: ButtonType.classic,
          onPressed: action,
        );
      },
    );
  }
}
