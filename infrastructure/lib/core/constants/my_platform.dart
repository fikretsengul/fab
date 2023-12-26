// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

import '../others/platform/platform_web.dart' if (dart.library.io) '../others/platform/platform_io.dart';

/// A wrapper class for checking the current platform the app is running on.
/// This class uses conditional imports to determine platform-specific details.
@immutable
final class MyPlatform {
  const MyPlatform();

  /// Checks if the current platform is Web.
  static bool isWeb = GeneralPlatform.isWeb;

  /// Checks if the current platform is macOS.
  static bool get isMacOS => GeneralPlatform.isMacOS;

  /// Checks if the current platform is Windows.
  static bool get isWindows => GeneralPlatform.isWindows;

  /// Checks if the current platform is Linux.
  static bool get isLinux => GeneralPlatform.isLinux;

  /// Checks if the current platform is Android.
  static bool get isAndroid => GeneralPlatform.isAndroid;

  /// Checks if the current platform is iOS.
  static bool get isIOS => GeneralPlatform.isIOS;

  /// Checks if the current platform is Fuchsia.
  static bool get isFuchsia => GeneralPlatform.isFuchsia;

  /// Checks if the current platform is a mobile platform (iOS or Android).
  static bool get isMobile => MyPlatform.isIOS || MyPlatform.isAndroid;

  /// Checks if the current platform is a desktop platform (macOS, Windows, or Linux).
  static bool get isDesktop => MyPlatform.isMacOS || MyPlatform.isWindows || MyPlatform.isLinux;
}
