import 'package:deps/core/commons/extensions.dart';
import 'package:deps/core/commons/utils.dart';
import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import '../../design.dart';

class FabAppBar extends StatelessWidget implements PreferredSizeWidget {
  FabAppBar({
    required this.title,
    this.leading,
    this.trailing,
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: Paddings.md.horizontal,
        child: Row(
          children: [
            leading ?? const AutoLeadingButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.titleMedium?.copyWith(
                    fontFamily: FontFamily.tTRamillasTrial,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            trailing ?? const SizedBox(width: 30, height: 30),
          ],
        ),
      ),
    );
  }
}
