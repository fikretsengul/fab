import '../_core/enums/failure_tag_enum.dart';
import '../_core/enums/permission_type_enum.dart';
import '../_core/i18n/translations.g.dart';
import '../analytics/failure/failure.dart';

class InvalidPermissionTypeFailure extends Failure {
  InvalidPermissionTypeFailure({required PermissionType type, super.exception, super.stack})
      : super(
          code: 'invalid-permission-failure',
          type: FailureType.exception,
          tag: FailureTag.permission,
          message: tr.failures.permissions.invalidPermissionType(type: type),
        );
}
