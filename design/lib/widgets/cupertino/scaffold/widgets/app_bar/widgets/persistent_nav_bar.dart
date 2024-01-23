import 'package:flutter/cupertino.dart';

import '../../../utils/measures.dart';
import '../../transitionable_navigation_bar.dart';

class PersistentNavigationBar extends StatelessWidget {
  const PersistentNavigationBar({
    required this.components,
    super.key,
    this.padding,
    this.middleVisible,
  });

  final NavigationBarStaticComponents components;
  final bool? middleVisible;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    Widget? middle = components.middle;

    if (middle != null) {
      middle = DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
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
    final Widget? backChevron = components.backChevron;
    final Widget? backLabel = components.backLabel;

    if (leading == null && backChevron != null && backLabel != null) {
      leading = SuperCupertinoNavigationBarBackButton.assemble(
        backChevron,
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
