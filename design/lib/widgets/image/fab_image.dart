import 'package:deps/packages/cached_network_image.dart';
import 'package:deps/packages/skeletonizer.dart';
import 'package:deps/packages/uicons.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/fab_theme.dart';
import '../card/fab_card.dart';

class FabImage extends StatelessWidget {
  const FabImage({
    required this.uri,
    this.width = 300,
    this.height = 300,
    this.onPressed,
    this.pressedOpacity = 0.4,
    this.radius = 16,
    this.border,
    this.useCupertinoRounder = false,
    super.key,
  });

  final double pressedOpacity;
  final String uri;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final double radius;
  final BoxBorder? border;
  final bool useCupertinoRounder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: uri,
      width: width,
      height: height,
      imageBuilder: (_, imageProvider) {
        return FabCard(
          useCupertinoRounder: useCupertinoRounder,
          pressedOpacity: pressedOpacity,
          onPressed: onPressed,
          border: border,
          radius: radius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        );
      },
      placeholder: (context, url) {
        return Skeletonizer(
          child: FabCard(
            useCupertinoRounder: useCupertinoRounder,
            pressedOpacity: pressedOpacity,
            onPressed: onPressed,
            border: border,
            radius: radius,
          ),
        );
      },
      errorWidget: (_, __, ___) {
        return FabCard(
          width: double.infinity,
          height: double.infinity,
          useCupertinoRounder: useCupertinoRounder,
          pressedOpacity: pressedOpacity,
          onPressed: onPressed,
          border: border,
          radius: radius,
          child: Icon(
            UIcons.solidRounded.exclamation,
            size: 20,
            color: context.fabTheme.errorColor,
          ),
        );
      },
    );
  }
}
