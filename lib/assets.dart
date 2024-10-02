import 'package:flutter/widgets.dart';

class Fonts {
  static const String nunito = "Nunito";
}

class Assets {
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/configs/dev.json)
  static const String dev = "assets/configs/dev.json";
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/configs/prod.json)
  static const String prod = "assets/configs/prod.json";
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/configs/test.json)
  static const String test = "assets/configs/test.json";
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/themes/default_theme.json)
  static const String defaultTheme = "assets/themes/default_theme.json";
}

class Images {
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/images/defaultProfilePicture.png)
  static AssetImage get defaultProfilePicture => const AssetImage("assets/images/defaultProfilePicture.png");
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/images/image_not_found.png)
  static AssetImage get imageNotFound => const AssetImage("assets/images/image_not_found.png");
  /// ![](file:///D:/source/flutter_advanced_boilerplate/assets/images/logo.png)
  static AssetImage get logo => const AssetImage("assets/images/logo.png");
}

