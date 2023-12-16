// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/fpdart.dart';

import '../failure/failure.dart';

/// A type definition for asynchronous operations that return either a [Failure] or a result of type [T].
///
/// This is typically used in scenarios where operations can either succeed or fail,
/// and the failure needs to be handled in a specific way.
typedef AsyncEither<T> = Future<Either<Failure, T>>;

/// A type definition for synchronous operations that return either a [Failure] or a result of type [T].
///
/// Similar to [AsyncEither], but for synchronous operations.
typedef SyncEither<T> = Either<Failure, T>;
