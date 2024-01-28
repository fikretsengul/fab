import 'package:deps/design/design.dart';
import 'package:flutter/cupertino.dart' hide CupertinoNavigationBarBackButton;

import '../../../../overridens/overriden_transitionable_navigation_bar.dart';
import '../../../utils/measures.dart';

class PersistentNavigationBar extends StatelessWidget {
  const PersistentNavigationBar({
    required this.components,
    required this.keys,
    super.key,
    this.backIcon,
    this.padding,
    this.middleVisible,
  });

  final NavigationBarStaticComponentsKeys keys;
  final NavigationBarStaticComponents components;
  final bool? middleVisible;
  final Widget? backIcon;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    Widget? middle = components.middle;

    if (middle != null) {
      middle = DefaultTextStyle(
        style: context.appTheme.appBarTitleNActions.copyWith(inherit: false),
        child: Semantics(header: true, child: middle),
      );

      middle = middleVisible == null
          ? middle
          : AnimatedOpacity(
              opacity: middleVisible! ? 1.0 : 0.0,
              duration: Measures.instance().standartAnimationDuration,
              child: middle,
            );
    }

    Widget? leading = components.leading;
    final backChevron = backIcon != null
        ? KeyedSubtree(
            key: keys.backChevronKey,
            child: backIcon!,
          )
        : components.backChevron;
    final Widget? backLabel = components.backLabel;

    if (leading == null && backChevron != null && backLabel != null) {
      leading = CupertinoNavigationBarBackButton.assemble(
        backChevron,
        context.appTheme.appBarTitleNActions.copyWith(inherit: false),
        backLabel,
      );
    }

    Widget paddedToolbar = NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: components.trailing,
      middleSpacing: 6,
    );

    if (padding != null) {
      paddedToolbar = Padding(
        padding: EdgeInsets.only(
          top: padding!.top,
          bottom: padding!.bottom,
        ),
        child: paddedToolbar,
      );
    }

    return SafeArea(
      bottom: false,
      child: paddedToolbar,
    );
  }
}
