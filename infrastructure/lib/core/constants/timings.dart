// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

/// A collection of commonly used timing durations.
@immutable
final class Timings {
  const Timings();

  /// Duration of 50 milliseconds.
  static const m050 = Duration(milliseconds: 50);

  /// Duration of 200 milliseconds.
  static const m200 = Duration(milliseconds: 200);

  /// Duration of 400 milliseconds.
  static const m400 = Duration(milliseconds: 400);

  /// Duration of 600 milliseconds.
  static const m600 = Duration(milliseconds: 600);

  /// Duration of 800 milliseconds.
  static const m800 = Duration(milliseconds: 800);

  /// Duration of 1 second.
  static const sec = Duration(seconds: 1);
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
