// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_boilerplate/utils/constants.dart';
// import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

// class CustomContainerTransform extends StatelessWidget {
//   const CustomContainerTransform({
//     required this.closedBuilder,
//     super.key,
//     this.openWidget,
//     this.closedBorderRadius,
//   });

//   final double? closedBorderRadius;
//   final Widget Function(BuildContext, void Function()) closedBuilder;
//   final Widget? openWidget;

//   @override
//   Widget build(BuildContext context) {
//     return OpenContainer(
//       transitionType: ContainerTransitionType.fadeThrough,
//       closedElevation: $constants.theme.defaultElevation,
//       openElevation: $constants.theme.defaultElevation,
//       closedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(
//             closedBorderRadius ?? $constants.theme.defaultBorderRadius,
//           ),
//         ),
//       ),
//       closedColor: getTheme(context).surface,
//       openColor: getTheme(context).surface,
//       middleColor: getTheme(context).surface,
//       tappable: openWidget != null,
//       openBuilder: (context, _) => openWidget ?? const SizedBox(),
//       closedBuilder: closedBuilder,
//     );
//   }
// }
