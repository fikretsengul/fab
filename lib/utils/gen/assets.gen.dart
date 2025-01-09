/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsConfigsGen {
  const $AssetsConfigsGen();

  /// File path: assets/configs/dev.json
  String get dev => 'assets/configs/dev.json';

  /// File path: assets/configs/prod.json
  String get prod => 'assets/configs/prod.json';

  /// File path: assets/configs/test.json
  String get test => 'assets/configs/test.json';

  /// List of all assets
  List<String> get values => [dev, prod, test];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/defaultProfilePicture.png
  AssetGenImage get defaultProfilePicture =>
      const AssetGenImage('assets/images/defaultProfilePicture.png');

  /// File path: assets/images/image_not_found.png
  AssetGenImage get imageNotFound =>
      const AssetGenImage('assets/images/image_not_found.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [defaultProfilePicture, imageNotFound, logo];
}

class $AssetsThemesGen {
  const $AssetsThemesGen();

  /// File path: assets/themes/default_theme.json
  String get defaultTheme => 'assets/themes/default_theme.json';

  /// List of all assets
  List<String> get values => [defaultTheme];
}

class Assets {
  Assets._();

  static const $AssetsConfigsGen configs = $AssetsConfigsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsThemesGen themes = $AssetsThemesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
