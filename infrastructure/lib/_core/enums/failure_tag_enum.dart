// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Enumerates various tags used to categorize failures.
enum FailureTag {
  /// Failure in a Cubit (BLoC pattern component).
  state,

  /// Failure related to network requests.
  network,

  /// Failure encountered in a repository layer.
  repository,

  /// Failure related to page or UI components.
  presentation,

  /// Uncaught or unexpected failure.
  uncaught,

  /// Permission failure
  permission,

  /// Indicates empty failure tag.
  empty,
}
