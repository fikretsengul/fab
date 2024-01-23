// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';

class CupertinoDialogConfig {
  const CupertinoDialogConfig({
    this.barrierColor,
    this.barrierLabel,
    this.barrierDismissible = true,
    this.semanticsDismissible = false,
    this.transitionDuration = const Duration(milliseconds: 250),
    this.transitionBuilder,
    this.anchorPoint,
  });

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  )? transitionBuilder;
  final Duration transitionDuration;
  final Color? barrierColor;
  final String? barrierLabel;
  final bool barrierDismissible;
  final bool semanticsDismissible;
  final Offset? anchorPoint;
}
