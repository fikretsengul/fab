import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_bar_material.dart';

class AppBarCupertino extends AppBarMaterial {
  AppBarCupertino({
    super.key,
    super.leading,
    super.automaticallyImplyLeading,
    String? title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.notificationPredicate,
    super.shape,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary,
    super.centerTitle,
    super.excludeHeaderSemantics,
    super.titleSpacing,
    super.toolbarOpacity,
    super.bottomOpacity,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency,
    super.clipBehavior,
  }) : super(
          surfaceTintColor: Colors.transparent,
          shadowColor: CupertinoColors.darkBackgroundGray,
          scrolledUnderElevation: .1,
          toolbarHeight: 44,
          title: title != null
              ? Text(
                  title,
                  style: const CupertinoThemeData().textTheme.navLargeTitleTextStyle.copyWith(letterSpacing: -1.5),
                )
              : null,
        );
}
