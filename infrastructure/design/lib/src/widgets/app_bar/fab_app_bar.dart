import 'package:deps/packages/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../../design.dart';
import '../../constants/radiuses.dart';
import 'others/custom_auto_router_back_button.dart';

class FabAppBar extends StatefulWidget implements PreferredSizeWidget {
  FabAppBar({
    required this.title,
    super.key,
  }) : preferredSize = const Size.fromHeight(46);

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
        preferredSize: const Size.fromHeight(2),
        child: Container(
          margin: Paddings.md.horizontal,
          height: ThemeSettings.borderWidth,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.onBackground,
            borderRadius: Radiuses.md.circularBorder,
          ),
        ),
      ),
      title: Padding(
        padding: Paddings.md.horizontal,
        child: Row(
          children: [
            const CustomAutoRouterBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: context.titleMedium!.copyWith(
                    fontFamily: FontFamily.tTRamillasTrial,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30, height: 30),
          ],
        ),
      ),
    );
  }
}
