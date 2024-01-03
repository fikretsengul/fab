import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/material.dart';

import '../_core/super/permissions/_core/permission_type_enum.dart';
import '../_core/super/super.dart';

@immutable
final class PermissionAlerts {
  void informDenied(PermissionType permissionType, {required VoidCallback onRetry}) {
    $.alert.showDialog(
      builder: (_) => AlertDialog(
        title: Text($.tr.core.permissions.dialog.denied.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.denied.description(context: permissionType)),
        actions: [
          TextButton(
            onPressed: () {
              $.alert.popDialog();
              onRetry();
            },
            child: Text($.tr.core.permissions.dialog.buttons.retry),
          ),
          TextButton(
            onPressed: $.alert.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  void informPermanentlyDenied(PermissionType permissionType) {
    $.alert.showDialog(
      builder: (_) => AlertDialog(
        title: Text($.tr.core.permissions.dialog.permanentlyDenied.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.permanentlyDenied.description(context: permissionType)),
        actions: [
          TextButton(
            child: Text($.tr.core.permissions.dialog.buttons.openSettings),
            onPressed: () {
              $.alert.popDialog();
              openAppSettings();
            },
          ),
          TextButton(
            onPressed: $.alert.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  void informRestricted(PermissionType permissionType) {
    $.alert.showDialog(
      builder: (_) => AlertDialog(
        title: Text($.tr.core.permissions.dialog.restricted.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.restricted.description(context: permissionType)),
        actions: [
          TextButton(
            onPressed: $.alert.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.understood),
          ),
        ],
      ),
    );
  }

  void informLimited(PermissionType permissionType) {
    $.alert.showDialog(
      builder: (_) => AlertDialog(
        title: Text($.tr.core.permissions.dialog.limited.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.limited.description(context: permissionType)),
        actions: [
          TextButton(
            child: Text($.tr.core.permissions.dialog.buttons.openSettings),
            onPressed: () {
              $.alert.popDialog();
              openAppSettings();
            },
          ),
          TextButton(
            onPressed: $.alert.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }

  void informProvisional(PermissionType permissionType) {
    $.alert.showDialog(
      builder: (_) => AlertDialog(
        title: Text($.tr.core.permissions.dialog.provisional.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.provisional.description),
        actions: [
          TextButton(
            onPressed: $.alert.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }
}
