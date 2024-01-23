// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/permission_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../super.dart';
import '../_core/permission_type.enum.dart';

@immutable
final class PermissionCupertinoAlerts {
  void informDenied(PermissionType permissionType, {required VoidCallback onRetry}) {
    $.dialog.showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
        title: Text($.tr.core.permissions.dialog.denied.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.denied.description(context: permissionType)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              $.dialog.popDialog();
              onRetry();
            },
            child: Text($.tr.core.permissions.dialog.buttons.retry),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: $.dialog.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  void informPermanentlyDenied(PermissionType permissionType) {
    $.dialog.showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
        title: Text($.tr.core.permissions.dialog.permanentlyDenied.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.permanentlyDenied.description(context: permissionType)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              $.dialog.popDialog();
              openAppSettings();
            },
            child: Text($.tr.core.permissions.dialog.buttons.openSettings),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: $.dialog.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.cancel),
          ),
        ],
      ),
    );
  }

  void informRestricted(PermissionType permissionType) {
    $.dialog.showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
        title: Text($.tr.core.permissions.dialog.restricted.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.restricted.description(context: permissionType)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: $.dialog.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.understood),
          ),
        ],
      ),
    );
  }

  void informLimited(PermissionType permissionType) {
    $.dialog.showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
        title: Text($.tr.core.permissions.dialog.limited.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.limited.description(context: permissionType)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              $.dialog.popDialog();
              openAppSettings();
            },
            child: Text($.tr.core.permissions.dialog.buttons.openSettings),
          ),
          CupertinoDialogAction(
            onPressed: $.dialog.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }

  void informProvisional(PermissionType permissionType) {
    $.dialog.showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
        title: Text($.tr.core.permissions.dialog.provisional.title(context: permissionType)),
        content: Text($.tr.core.permissions.dialog.provisional.description),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: $.dialog.popDialog,
            child: Text($.tr.core.permissions.dialog.buttons.ok),
          ),
        ],
      ),
    );
  }
}
