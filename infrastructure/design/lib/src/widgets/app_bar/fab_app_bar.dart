import 'package:deps/core/commons/constants.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../../../design.dart';

class _CustomBackButton extends StatelessWidget {
  const _CustomBackButton();

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return Padding(
        padding: Paddings.sm.all,
        child: FabIconButton(
          icon: UIcons.boldRounded.angle_left,
          onPressed: () => Navigator.maybePop(context),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class FabAppBar extends StatefulWidget implements PreferredSizeWidget {
  FabAppBar({super.key}) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  State<FabAppBar> createState() => _FabAppBarState();
}

class _FabAppBarState extends State<FabAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.transparent,
      leading: const _CustomBackButton(),
      title: const Text('Flutter Advanced Boilerplate'),
    );
  }
}
