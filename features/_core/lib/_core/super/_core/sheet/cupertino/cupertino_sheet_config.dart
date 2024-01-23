// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class CupertinoSheetConfig {
  const CupertinoSheetConfig({
    this.barrierColor = kCupertinoModalBarrierColor,
    this.barrierDismissible = true,
    this.semanticsDismissible = false,
    this.anchorPoint,
    this.useRootNavigator = true,
    this.filter,
  });

  final ui.ImageFilter? filter;
  final Offset? anchorPoint;
  final Color barrierColor;
  final bool barrierDismissible;
  final bool semanticsDismissible;
  final bool useRootNavigator;
}
