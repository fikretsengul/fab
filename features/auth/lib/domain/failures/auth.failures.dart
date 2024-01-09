// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';

class WrongCredentialsAuthFailure extends Failure {
  WrongCredentialsAuthFailure()
      : super(
          code: 'wrong-credentials-auth-failure',
          type: FailureType.destructive,
          tag: FailureTag.repository,
          message: $.tr.auth.failures.wrongCredentials,
        );
}
