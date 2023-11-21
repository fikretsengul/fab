// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

/// `Durations` is a collection of commonly used `Duration` constants.
/// This immutable class provides a set of predefined durations for consistent timing
/// throughout the application. It can be used for animations, delays, transitions, and more.
@immutable
class Durations {
  const Durations._();

  /// A very short delay of 50 milliseconds, useful for minimal pauses.
  static const delay = Duration(milliseconds: 50);

  /// A fast duration of 300 milliseconds, typically used for quick animations.
  static const fast = Duration(milliseconds: 300);

  /// A medium duration of 500 milliseconds, suitable for standard animations.
  static const medium = Duration(milliseconds: 500);

  /// A slower duration of 750 milliseconds, for more pronounced animations.
  static const slow = Duration(milliseconds: 750);

  /// An extra fast duration of 150 milliseconds, for very quick transitions.
  static const xFast = Duration(milliseconds: 150);

  /// An extra slow duration of 900 milliseconds, for longer lasting effects.
  static const xSlow = Duration(milliseconds: 900);
}

extension DurationsExt on Duration {
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        this,
        callback,
      );
}
