// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

html.Navigator _navigator = html.window.navigator;

/// `GeneralPlatform` provides platform-specific checks for different operating systems and environments.
/// This version of the class is tailored for web applications using 'dart:html'.
class GeneralPlatform {
  /// Checks if the current platform is Web.
  static bool get isWeb => true;

  /// Checks if the current platform is macOS. This check also ensures that it is not an iOS platform.
  static bool get isMacOS => _navigator.appVersion.contains('Mac OS') && !GeneralPlatform.isIOS;

  /// Checks if the current platform is Windows.
  static bool get isWindows => _navigator.appVersion.contains('Win');

  /// Checks if the current platform is Linux.
  /// The check includes a condition to differentiate from Android devices.
  static bool get isLinux =>
      (_navigator.appVersion.contains('Linux') || _navigator.appVersion.contains('x11')) && !isAndroid;

  /// Checks if the current platform is Android.
  static bool get isAndroid => _navigator.appVersion.contains('Android ');

  /// Checks if the current platform is iOS.
  /// iOS detection includes special handling for newer versions and iPadOS.
  static bool get isIOS {
    return hasMatch(_navigator.platform, '/iPad|iPhone|iPod/') ||
        (_navigator.platform == 'MacIntel' && _navigator.maxTouchPoints! > 1);
  }

  /// Checks if the current platform is Fuchsia. Always returns false for web.
  static bool get isFuchsia => false;

  /// Checks if the current platform is a desktop platform (macOS, Windows, or Linux).
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Helper method to check if a string matches a given pattern.
  static bool hasMatch(String? value, String pattern) {
    return value != null && RegExp(pattern).hasMatch(value);
  }
}
