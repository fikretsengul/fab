// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

/// `GeneralPlatform` provides platform-specific checks for different operating systems.
///
/// This class uses the `Platform` class from `dart:io` to determine the current operating system
/// the application is running on. It provides static getters to check for specific platforms.
class GeneralPlatform {
  /// Checks if the current platform is Web.
  /// Always returns false as `Platform` from `dart:io` does not support Web.
  static bool get isWeb => false;

  /// Checks if the current platform is macOS.
  static bool get isMacOS => Platform.isMacOS;

  /// Checks if the current platform is Windows.
  static bool get isWindows => Platform.isWindows;

  /// Checks if the current platform is Linux.
  static bool get isLinux => Platform.isLinux;

  /// Checks if the current platform is Android.
  static bool get isAndroid => Platform.isAndroid;

  /// Checks if the current platform is iOS.
  static bool get isIOS => Platform.isIOS;

  /// Checks if the current platform is Fuchsia.
  static bool get isFuchsia => Platform.isFuchsia;

  /// Checks if the current platform is a desktop platform (macOS, Windows, or Linux).
  static bool get isDesktop => Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
