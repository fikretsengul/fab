// ignore_for_file: avoid_setters_without_getters, avoid_returning_this

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/widgets.dart';

import '../../../alerts/permission_alerts.dart';
import '_core/permission_failures.dart';
import '_core/permission_type_enum.dart';

typedef PermissionCallback = VoidCallback;
typedef FailureCallback = ValueChanged<Failure>;

final class Permissions {
  final PermissionAlerts _permissionAlerts = PermissionAlerts();

  /// The user denied access to the requested feature, permission needs to be
  /// asked first.
  PermissionCallback? _denied;

  /// The user granted access to the requested feature.
  PermissionCallback? _granted;

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  PermissionCallback? _permanentlyDenied;

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  PermissionCallback? _restricted;

  /// The user has authorized this application for limited access. So far this
  /// is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+).*
  PermissionCallback? _limited;

  /// The application is provisionally authorized to post non-interruptive user
  /// notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  PermissionCallback? _provisional;

  /// Failure callback.
  FailureCallback? _onFailure;

  Future<void> request(PermissionType permissionType, {bool handleAlerts = true}) async {
    try {
      final permission = _getPermissionFromType(permissionType);

      if (permission == Permission.locationWhenInUse ||
          permission == Permission.locationAlways ||
          permission == Permission.location) {
        await permission.shouldShowRequestRationale;
      }

      final status = await permission.request();

      switch (status) {
        case PermissionStatus.granted:
          _granted?.call();
        case PermissionStatus.denied:
          _denied?.call();
          if (handleAlerts) {
            _permissionAlerts.informDenied(permissionType, onRetry: () => request(permissionType));
          }
        case PermissionStatus.permanentlyDenied:
          _permanentlyDenied?.call();
          if (handleAlerts) {
            _permissionAlerts.informPermanentlyDenied(permissionType);
          }
        case PermissionStatus.restricted:
          _restricted?.call();
          if (handleAlerts) {
            _permissionAlerts.informRestricted(permissionType);
          }
        case PermissionStatus.limited:
          _limited?.call();
          if (handleAlerts) {
            _permissionAlerts.informLimited(permissionType);
          }
        case PermissionStatus.provisional:
          _provisional?.call();
          if (handleAlerts) {
            _permissionAlerts.informProvisional(permissionType);
          }
      }
    } on InvalidPermissionTypeFailure catch (e) {
      _onFailure?.call(e);
    } on Exception catch (e) {
      _onFailure?.call(UnknownPermissionRequestError(exception: e));
      if (handleAlerts) {
        _permissionAlerts.informProvisional(permissionType);
      }
    }
  }

  Permissions when({
    PermissionCallback? denied,
    PermissionCallback? granted,
    PermissionCallback? permanentlyDenied,
    PermissionCallback? restricted,
    PermissionCallback? limited,
    PermissionCallback? provisional,
    FailureCallback? onFailure,
  }) {
    _denied = denied;
    _granted = granted;
    _permanentlyDenied = permanentlyDenied;
    _restricted = restricted;
    _limited = limited;
    _provisional = provisional;
    _onFailure = onFailure;

    return this;
  }

  Permission _getPermissionFromType(PermissionType permissionType) {
    final permissionName = permissionType.toString().split('.').last;
    for (final permission in Permission.values) {
      if (permission.toString().split('.').last == permissionName) {
        return permission;
      }
    }

    throw InvalidPermissionTypeFailure(type: permissionType);
  }
}
