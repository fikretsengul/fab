import 'package:deps/features/features.dart';
import 'package:deps/packages/smooth_sheets.dart';
import 'package:flutter/material.dart';

import '../../design.dart';

class FabModal extends StatelessWidget {
  const FabModal({
    required this.child,
    this.topLeadingWidget,
    this.title,
    super.key,
  });

  final Widget? topLeadingWidget;
  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SheetContentScaffold(
        backgroundColor: context.fabTheme.backgroundColor,
        body: PaddingSymmetric.xs(
          vertical: true,
          child: FabScaffold(
            appBar: FabAppBarSettings(
              title: const Text('cart.'),
            ),
            child: child,
          ),
        ),
/*         Column(
          children: [
            TopBar(
              title: title,
              leadingWidget: topLeadingWidget,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.fabTheme.borderColor.withOpacity(1),
                    width: 0,
                  ),
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ), */
      ),
    );
  }
}
