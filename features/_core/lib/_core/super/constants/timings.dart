// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

/// A collection of commonly used timing durations.
@immutable
final class Timings {
  /// Duration of 0 milliseconds.
  final zero = Duration.zero;

  /// Duration of 50 milliseconds.
  final mil050 = const Duration(milliseconds: 50);

  /// Duration of 200 milliseconds.
  final mil200 = const Duration(milliseconds: 200);

  /// Duration of 400 milliseconds.
  final mil400 = const Duration(milliseconds: 400);

  /// Duration of 600 milliseconds.
  final mil600 = const Duration(milliseconds: 600);

  /// Duration of 800 milliseconds.
  final mil800 = const Duration(milliseconds: 800);

  /// Duration of 1 second.
  final sec = const Duration(seconds: 1);

  /// Duration of 2 second.
  final sec2 = const Duration(seconds: 2);
}

/// Extension on `Duration` to provide a simple delay mechanism.
extension TimingsExt on Duration {
  /// Delays the execution of a callback function by the duration.
  /// If no callback is provided, it simply waits for the duration.
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        this,
        callback,
      );
}
