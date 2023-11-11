// ignore_for_file: comment_references

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Determines what [Page] will be constructed when routing to path.
enum PageType {
  /// Automatically decide on the type of Page to construct. Conditions based
  /// on platform type and PageDelegate type.
  auto,

  /// Declares a [PageDelegate] to use a [MaterialPage]
  /// when constructing widget.
  material,

  /// Declares a [PageDelegate] to use a [CupertinoPage]
  /// when constructing widget.
  cupertino,

  /// Declares a [PageDelegate] to use a [NoTransitionPage]
  /// when constructing widget.
  noTransition;
}
