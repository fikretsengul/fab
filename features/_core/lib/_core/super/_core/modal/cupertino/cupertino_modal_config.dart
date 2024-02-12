// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const _cupertinoBarrierColor = Color(0x18000000);
const _cupertinoTransitionDuration = Duration(milliseconds: 300);
const _cupertinoTransitionCurve = Curves.fastEaseInToSlowEaseOut;

class CupertinoModalConfig {
  const CupertinoModalConfig({
    this.enablePullToDismiss = true,
    this.maintainState = true,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.barrierColor = _cupertinoBarrierColor,
    this.transitionDuration = _cupertinoTransitionDuration,
    this.transitionCurve = _cupertinoTransitionCurve,
  });

  final Color? barrierColor;

  final bool barrierDismissible;

  final String? barrierLabel;

  final bool enablePullToDismiss;

  final bool maintainState;

  final Duration transitionDuration;

  final Curve transitionCurve;
}
