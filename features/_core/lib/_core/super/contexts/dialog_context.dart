// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:flutter/material.dart';

import '../../../router/router.gr.dart';
import '../_core/dialog/dialog_config.dart';
import '../_core/modal/modal_config.dart';
import '../_core/sheet/sheet_config.dart';
import '../_core/sheet/sheet_wrapper.dart';
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

  Future<T?> showDialog<T>({
    required Widget Function(BuildContext context) builder,
    bool canPop = true,
    VoidCallback? onPop,
    DialogConfig config = const DialogConfig(),
  }) async {
    if (!(_scaffoldContext?.mounted ?? true)) {
      return null;
    }

    final dialog = builder(_scaffoldContext!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          DialogWrapperRoute(
            builder: (_) => dialog,
            canPop: canPop,
            onPop: onPop,
            dialogConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<T?> showModal<T>({
    required Widget Function(BuildContext context) builder,
    bool canPop = true,
    VoidCallback? onPop,
    ModalConfig config = const ModalConfig(),
  }) async {
    if (!(_scaffoldContext?.mounted ?? true)) {
      return null;
    }

    final dialog = builder(_scaffoldContext!);
    _addDialogVisible(dialog);

    return _navigator
        .push<T>(
          ModalWrapperRoute(
            builder: (_) => dialog,
            canPop: canPop,
            onPop: onPop,
            modalConfig: config,
          ),
        )
        .whenComplete(
          () => _removeDialogVisible(widget: dialog),
        );
  }

  Future<void> showSheet({
    required Widget Function(BuildContext context) builder,
    bool canPop = true,
    VoidCallback? onPop,
    SheetConfig config = const SheetConfig(),
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
      enableDrag: canPop && config.enableDrag,
      transitionAnimationController: config.transitionAnimationController,
      (_) => SheetWrapper(
        builder: (_) => dialog,
        canPop: canPop,
        onPop: onPop,
      ),
    );

    await bottomSheetController.closed;
    _removeDialogVisible(widget: dialog);

    return;
  }
}
