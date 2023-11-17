import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// `PageType` enum defines the type of page to be constructed in the routing system.
/// It allows specifying different page behaviors based on the platform or custom requirements.
enum PageType {
  /// Automatically decides the type of page to construct.
  /// The decision is based on platform type and the context in which it is used.
  /// This option provides flexibility, especially for apps targeting multiple platforms.
  auto,

  /// Specifies that a [MaterialPage] should be used when constructing the page.
  /// This is typically used for apps following Material Design guidelines.
  material,

  /// Specifies that a [CupertinoPage] should be used when constructing the page.
  /// This is typically used for apps that aim to mimic the iOS look and feel.
  cupertino,

  /// Specifies the use of a NoTransitionPage for the page construction.
  /// This option is useful for creating pages without any transition animations.
  noTransition;
}
