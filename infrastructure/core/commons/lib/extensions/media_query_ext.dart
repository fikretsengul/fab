// ignore_for_file: prefer_dedicated_media_query_method, boolean_prefix
import 'package:flutter/material.dart';

import '../widgets/my_platform.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  bool get shouldAlwaysUse24HourFormat => MediaQuery.of(this).alwaysUse24HourFormat;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;

  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;
  bool get shouldShowNavbar => width > 800;
  bool get isPhone => mediaQueryShortestSide < 600;
  bool get isSmallTablet => mediaQueryShortestSide >= 600;
  bool get isLargeTablet => mediaQueryShortestSide >= 720;
  bool get isTablet => isSmallTablet || isLargeTablet;

  Size get mqSize => MediaQuery.sizeOf(this);
  double get mqHeight => mqSize.height;
  double get mqWidth => mqSize.width;

  EdgeInsets get mqPadding => MediaQuery.paddingOf(this);
  EdgeInsets get mqViewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get mqViewInsets => MediaQuery.viewInsetsOf(this);
  Orientation get mqOrientation => MediaQuery.orientationOf(this);
  bool get mqAlwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);
  double get mqDevicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  Brightness get mqPlatformBrightness => MediaQuery.platformBrightnessOf(this);
  TextScaler get mqTextScaler => MediaQuery.textScalerOf(this);

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
  T? responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    var deviceWidth = mediaQuerySize.shortestSide;

    if (MyPlatform.isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }
    if (deviceWidth >= 1200 && desktop != null) {
      return desktop;
    }
    if (deviceWidth >= 600 && tablet != null) {
      return tablet;
    }

    return mobile;
  }
}
