// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Enum `LogType` defines different levels of logging severity.
///
/// - verbose: Detailed and potentially verbose information, typically for debugging.
/// - info: General informational messages.
/// - debug: Messages useful for debugging purposes.
/// - warning: Warnings indicating potential issues or caution required.
/// - error: Error messages indicating failures or significant issues.
enum LogType { verbose, info, debug, warning, error }

/// Enum `FailureType` categorizes the nature of a failure.
///
/// - constructive: Represents a failure that leads to positive changes or adaptations.
/// - destructive: Represents a failure that causes loss or damage to the system.
/// - exception: Represents an exceptional failure or error condition.
enum FailureType { constructive, destructive, exception }

/// Enum `FailureTag` provides specific context tags for failures.
///
/// - cubit: Failures related to the Cubit (state management).
/// - dio: Failures occurring in the Dio HTTP client.
/// - repository: Failures associated with data repositories.
/// - page: Failures specific to page-level components or logic.
/// - uncaught: Uncaught or unexpected failures.
enum FailureTag { cubit, dio, repository, page, uncaught }
