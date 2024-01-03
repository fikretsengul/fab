// ignore_for_file: avoid_setters_without_getters

import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/widgets.dart';

import '../_core/enums/permission_type_enum.dart';
import 'failures.dart';

typedef PermissionCallback = VoidCallback;

final class Permissions {
  PermissionCallback? _onPermissionDenied;
  PermissionCallback? _onPermissionGranted;
  PermissionCallback? _onPermissionPermanentlyDenied;

  set onPermissionDenied(PermissionCallback? callback) {
    _onPermissionDenied = callback;
  }

  set onPermissionGranted(PermissionCallback? callback) {
    _onPermissionGranted = callback;
  }

  set onPermissionPermanentlyDenied(PermissionCallback? callback) {
    _onPermissionPermanentlyDenied = callback;
  }

  /// execute request permission
  /// gets permission from PermissionType enum value and request permission
  /// handle permission status and call callback function
  /// if permission is granted, call onPermissionGranted callback
  /// if permission is denied, call onPermissionDenied callback
  /// if permission is permanently denied, call onPermissionPermanentlyDenied callback
  Future<void> request(PermissionType permissionType) async {
    final permission = _getPermissionFromType(permissionType);

    if (permission == Permission.locationWhenInUse ||
        permission == Permission.locationAlways ||
        permission == Permission.location) {
      await permission.shouldShowRequestRationale;
    }

    final status = await permission.request();

    if (status.isGranted) {
      _onPermissionGranted?.call();
    } else if (status.isDenied) {
      _onPermissionDenied?.call();
    } else if (status.isPermanentlyDenied) {
      _onPermissionPermanentlyDenied?.call();
    }
  }

  Permission _getPermissionFromType(PermissionType permissionType) {
    return switch (permissionType) {
      PermissionType.camera => Permission.camera,
      PermissionType.storage => Permission.storage,
      PermissionType.recordAudio => Permission.microphone,
      PermissionType.writeContacts => Permission.contacts,
      PermissionType.readContacts => Permission.contacts,
      PermissionType.whenInUseLocation => Permission.locationWhenInUse,
      PermissionType.alwaysLocation => Permission.locationAlways,
      PermissionType.notification => Permission.notification,
      PermissionType.photos => Permission.photos,
      _ => throw InvalidPermissionTypeFailure(type: permissionType)
    };
  }
}
