import 'package:deps/packages/awesome_extensions.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../../../design.dart';

class _CustomBackButton extends StatelessWidget {
  const _CustomBackButton();

  @override
  Widget build(BuildContext context) {
    if (Navigator.canPop(context)) {
      return Row(
        children: [
          FabIconButton(
            icon: UIcons.boldRounded.angle_left,
            buttonType: ButtonType.classic,
            onPressed: () => Navigator.maybePop(context),
          ),
          Paddings.md.horizontal,
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class FabAppBar extends StatefulWidget implements PreferredSizeWidget {
  FabAppBar({
    required this.title,
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;

  @override
  final Size preferredSize;

  @override
  State<FabAppBar> createState() => _FabAppBarState();
}

class _FabAppBarState extends State<FabAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Container(
          color: context.theme.colorScheme.onBackground,
          height: ThemeSettings.borderWidth,
        ),
      ),
      title: Padding(
        padding: Paddings.sm.symmetric(h: true),
        child: Row(
          children: [
            const _CustomBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  style: context.titleMedium!.copyWith(
                    fontFamily: FontFamily.fogtwoNo5,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            Paddings.md.horizontal,
            Container(
              color: Colors.red,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
