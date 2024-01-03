import 'package:deps/infrastructure/infrastructure.dart';

import '../../super.dart';
import 'permission_type_enum.dart';

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
