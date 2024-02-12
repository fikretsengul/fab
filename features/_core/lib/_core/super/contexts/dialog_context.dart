// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:flutter/material.dart';

import '../../../router/router.gr.dart';
import '../_core/dialog/cupertino/cupertino_dialog_config.dart';
import '../_core/dialog/material/material_dialog_config.dart';
import '../_core/modal/cupertino/cupertino_modal_config.dart';
import '../_core/modal/material/material_modal_config.dart';
import '../_core/sheet/cupertino/cupertino_sheet_config.dart';
import '../_core/sheet/material/material_sheet_config.dart';
import '../_core/sheet/material/material_sheet_wrapper.dart';
import 'navigator_context.dart';

@immutable
final class DialogContext {
  DialogContext(this._navigator);

  final NavigatorContext _navigator;

  final ValueNotifier<List<Widget>> _dialogs = ValueNotifier([]);
  BuildContext? get _scaffoldContext => _navigator.scaffoldKey.currentContext;
  ScaffoldState? get _scaffoldState => _navigator.scaffoldKey.currentState;

  bool get hasDialogVisible => _dialogs.value.isNotEmpty;

  void _addDialogVisible(Widget widget) {
    _dialogs.value.add(widget);
  }

  void _removeDialogVisible({Widget? widget}) {
    if (widget != null) {
      _dialogs.value.remove(widget);
    } else {
      _dialogs.value.removeLast();
    }
  }

  void popAllDialogs() {
    for (final _ in _dialogs.value) {
      popDialog();
    }
    _resetDialogRegisters();
  }

  Future<void> popDialog<T extends Object>([T? result]) async {
    if (hasDialogVisible) {
      await _navigator.pop<T>(result);
    }
  }

  Future<void> popDialogForced<T extends Object>([T? result]) async {
    if (hasDialogVisible) {
      await _navigator.popForced<T>(result);
    }
  }

  void _resetDialogRegisters() {
    _dialogs.value.clear();
  }

  Future<T?> showMaterialDialog<T>({
    required Widget Function(BuildContext context) builder,
    MaterialDialogConfig config = const MaterialDialogConfig(),
  }) async {
    final dialog = builder(_navigator.context!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          MaterialDialogWrapperRoute(
            builder: (_) => dialog,
            dialogConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<T?> showCupertinoDialog<T>({
    required Widget Function(BuildContext context) builder,
    CupertinoDialogConfig config = const CupertinoDialogConfig(),
  }) async {
    final dialog = builder(_navigator.context!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          CupertinoDialogWrapperRoute(
            builder: (_) => dialog,
            dialogConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<T?> showMaterialModal<T>({
    required Widget Function(BuildContext context) builder,
    MaterialModalConfig config = const MaterialModalConfig(),
  }) async {
    final dialog = builder(_navigator.context!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          MaterialModalWrapperRoute(
            builder: (_) => dialog,
            modalConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<T?> showCupertinoModal<T>({
    required Widget Function(BuildContext context) builder,
    CupertinoModalConfig config = const CupertinoModalConfig(),
  }) async {
    final dialog = builder(_navigator.context!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          CupertinoModalWrapperRoute(
            builder: (_) => dialog,
            modalConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<void> showMaterialSheet({
    required Widget Function(BuildContext context) builder,
    MaterialSheetConfig config = const MaterialSheetConfig(),
  }) async {
    if (!(_scaffoldContext?.mounted ?? true)) {
      return;
    }

    final dialog = builder(_scaffoldContext!);
    _addDialogVisible(dialog);

    final bottomSheetController = _scaffoldState!.showBottomSheet(
      backgroundColor: config.backgroundColor,
      elevation: config.elevation,
      shape: config.shape,
      clipBehavior: config.clipBehavior,
      constraints: config.constraints,
      enableDrag: config.enableDrag,
      transitionAnimationController: config.transitionAnimationController,
      (_) => MaterialSheetWrapper(
        builder: (_) => dialog,
      ),
    );

    await bottomSheetController.closed;
    _removeDialogVisible(widget: dialog);

    return;
  }

  Future<T?> showCupertinoSheet<T>({
    required Widget Function(BuildContext context) builder,
    CupertinoSheetConfig config = const CupertinoSheetConfig(),
  }) async {
    final dialog = builder(_navigator.context!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          CupertinoSheetWrapperRoute(
            builder: (_) => dialog,
            dialogConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }
}
