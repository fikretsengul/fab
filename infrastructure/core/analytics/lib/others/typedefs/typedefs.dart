// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/fpdart.dart';

import '../../../failure.dart';

/// Typedef `AsyncEither` represents an asynchronous operation that
/// returns an `Either` type from the `fpdart` package.
///
/// This is typically used for asynchronous operations that may result
/// in either a `Failure` or a successful result of type `T`.
/// - `Failure`: Represents an error or failure case.
/// - `T`: Represents the successful result type.
typedef AsyncEither<T> = Future<Either<Failure, T>>;

/// Typedef `SyncEither` represents a synchronous operation that
/// returns an `Either` type from the `fpdart` package.
///
/// This is used for synchronous operations or calculations that may
/// result in either a `Failure` or a successful result of type `T`.
/// - `Failure`: Represents an error or failure case.
/// - `T`: Represents the successful result type.
typedef SyncEither<T> = Either<Failure, T>;
