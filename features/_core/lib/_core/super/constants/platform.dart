// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

import '../../../widgets/_core/platform/platform_web.dart'
    if (dart.library.io) '../../../widgets/_core/platform/platform_io.dart';

/// A wrapper class for checking the current platform the app is running on.
/// This class uses conditional imports to determine platform-specific details.
@immutable
final class Platform {
  Platform();

  /// Checks if the current platform is Web.
  final bool isWeb = GeneralPlatform.isWeb;

  /// Checks if the current platform is macOS.
  final bool isMacOS = GeneralPlatform.isMacOS;

  /// Checks if the current platform is Windows.
  final bool isWindows = GeneralPlatform.isWindows;

  /// Checks if the current platform is Linux.
  final bool isLinux = GeneralPlatform.isLinux;

  /// Checks if the current platform is Android.
  final bool isAndroid = GeneralPlatform.isAndroid;

  /// Checks if the current platform is iOS.
  final bool isIOS = GeneralPlatform.isIOS;

  /// Checks if the current platform is Fuchsia.
  final bool isFuchsia = GeneralPlatform.isFuchsia;

  /// Checks if the current platform is a mobile platform (iOS or Android).
  late final bool isMobile = isIOS || isAndroid;

  /// Checks if the current platform is a desktop platform (macOS, Windows, or Linux).
  late final bool isDesktop = isMacOS || isWindows || isLinux;
}
