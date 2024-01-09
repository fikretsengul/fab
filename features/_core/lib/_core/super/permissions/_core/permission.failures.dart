// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/infrastructure.dart';

import '../../super.dart';
import 'permission_type.enum.dart';

class UnknownPermissionRequestError extends Failure {
  UnknownPermissionRequestError({super.exception, super.stack})
      : super(
          code: 'unknown-permission-request-error',
          type: FailureType.exception,
          tag: FailureTag.permission,
          message: $.tr.core.permissions.failures.unknownPermissionRequest,
        );
}

class InvalidPermissionTypeFailure extends Failure {
  InvalidPermissionTypeFailure({required PermissionType type, super.exception, super.stack})
      : super(
          code: 'invalid-permission-failure',
          type: FailureType.exception,
          tag: FailureTag.permission,
          message: $.tr.core.permissions.failures.invalidPermissionType(type: type),
        );
}
