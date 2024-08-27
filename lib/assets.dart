import 'package:flutter/widgets.dart';

class Fonts {
  static const String almarai = "Almarai";
}

class Assets {
  /// ![](file:///D:/source/road_maintenance/assets/configs/dev.json)
  static const String dev = "assets/configs/dev.json";
  /// ![](file:///D:/source/road_maintenance/assets/configs/prod.json)
  static const String prod = "assets/configs/prod.json";
  /// ![](file:///D:/source/road_maintenance/assets/configs/test.json)
  static const String test = "assets/configs/test.json";
  /// ![](file:///D:/source/road_maintenance/assets/themes/default_theme.json)
  static const String defaultTheme = "assets/themes/default_theme.json";
  /// ![](file:///D:/source/road_maintenance/assets/themes/r_m_theme.json)
  static const String rMTheme = "assets/themes/r_m_theme.json";
}

class Images {
  /// ![](file:///D:/source/road_maintenance/assets/images/image_not_found.png)
  static AssetImage get imageNotFound => const AssetImage("assets/images/image_not_found.png");
  /// ![](file:///D:/source/road_maintenance/assets/images/logo.png)
  static AssetImage get logo => const AssetImage("assets/images/logo.png");
  /// ![](file:///D:/source/road_maintenance/assets/images/logo_main.png)
  static AssetImage get logoMain => const AssetImage("assets/images/logo_main.png");
}

