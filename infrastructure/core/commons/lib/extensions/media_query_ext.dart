import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaQuerySize => MediaQuery.sizeOf(this);
  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;

  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);
  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  bool get alwaysUse24HourFormat => MediaQuery.alwaysUse24HourFormatOf(this);
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;
  bool get showNavbar => width > 800;
  bool get isPhone => mediaQueryShortestSide < 600;
  bool get isSmallTablet => mediaQueryShortestSide >= 600;
  bool get isLargeTablet => mediaQueryShortestSide >= 720;
  bool get isTablet => isSmallTablet || isLargeTablet;

  /// Returns a specific value according to the screen size
  /// if the device width is higher than or equal to 1200 return
  /// [desktop] value. if the device width is higher than  or equal to 600
  /// and less than 1200 return [tablet] value.
  /// if the device width is less than 300  return [watch] value.
  /// in other cases return [mobile] value.
/*   T? responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
  }) {
    var deviceWidth = mediaQuerySize.shortestSide;
    if (MyPlatform.isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }
    if (deviceWidth >= 1200 && desktop != null) return desktop;
    if (deviceWidth >= 600 && tablet != null) return tablet;
    return mobile;
  } */
}
