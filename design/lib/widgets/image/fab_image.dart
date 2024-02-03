import 'package:deps/packages/cached_network_image_plus.dart';
import 'package:flutter/material.dart';

import '../card/fab_card.dart';

class FabImage extends StatelessWidget {
  const FabImage({
    required this.uri,
    this.width = 300,
    this.height = 300,
    this.onPressed,
    this.radius = 16,
    this.border,
    this.useCupertinoRounder = false,
    super.key,
  });

  final String uri;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final double radius;
  final BoxBorder? border;
  final bool useCupertinoRounder;

  @override
  Widget build(BuildContext context) {
    return CacheNetworkImagePlus(
      imageUrl: uri,
      width: width,
      height: height,
      borderRadius: radius,
      imageBuilder: (_, imageProvider) {
        return FabCard(
          useCupertinoRounder: useCupertinoRounder,
          onPressed: onPressed,
          border: border,
          radius: radius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
