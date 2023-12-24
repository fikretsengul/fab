// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../failure/failure.dart';

/// `IFailureObserver` is an abstract interface defining a contract
/// for observing and handling failures.
///
/// This interface is intended to be implemented by classes that need to
/// respond to or log failures occurring within the application. It provides
/// a single method to be called when a failure is encountered.
abstract class IFailureObserver {
  /// Called when a [Failure] is encountered in the application.
  ///
  /// Implement this method to define how failures should be handled,
  /// logged, or reported. The method provides the [Failure] object
  /// containing details about the failure.
  ///
  /// [failure]: The [Failure] instance representing the encountered failure.
  void onFailure(Failure failure);
}
