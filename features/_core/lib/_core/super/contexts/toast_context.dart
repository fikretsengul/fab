// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file, avoid_setters_without_getters

import 'dart:math' as math;

import 'package:deps/design/design.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:flutter/cupertino.dart';

import '../_core/toast/toast.dart';
import '../_core/toast/toast_wrapper.dart';
import 'navigator_context.dart';

enum ToastAlignment { top, bottom }

enum ToastLength { short, medium, long, ages, never }

enum ToastDismissDirection { up, down, horizontal }

class ToastModel {
  ToastModel({
    required this.controller,
    this.position = 0,
    this.isExpanded = false,
    this.overlayEntry,
  });

  double position;
  bool isExpanded;
  AnimationController controller;
  OverlayEntry? overlayEntry;

  void dispose() {
    overlayEntry?.remove();
    controller.dispose();
  }
}

final class ToastContext {
  ToastContext(this._navigator);

  final NavigatorContext _navigator;

  final List<ToastModel> _overlays = [];

  OverlayState? _overlayState;
  int _showMaxToast = 5;

  set showMaxToastNumber(int val) {
    assert(val > 0, 'Show toast number must be positive.');
    _showMaxToast = val;
  }

  ToastDismissDirection _getDefaultDismissDirection(ToastDismissDirection? dismissDirection, ToastAlignment alignment) {
    if (dismissDirection == null) {
      if (alignment == ToastAlignment.top) {
        return ToastDismissDirection.up;
      } else if (alignment == ToastAlignment.bottom) {
        return ToastDismissDirection.down;
      } else {
        return ToastDismissDirection.horizontal;
      }
    } else {
      return dismissDirection;
    }
  }

  Future<void> showAlert({
    required IFailure failure,
    bool isClosable = false,
    double expandedHeight = 150,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.fastLinearToSlowEaseIn,
    bool useSafeArea = true,
    ToastAlignment alignment = ToastAlignment.top,
    ToastLength length = ToastLength.medium,
    ToastDismissDirection? dismissDirection,
  }) async {
    if (failure.type == FailureType.empty) {
      return;
    }

    final child = switch (failure.type) {
      FailureType.constructive => FabAlert(
          color: const Color(0xFF40DBA3),
          icon: CupertinoIcons.checkmark_circle_fill,
          message: failure.message,
        ),
      _ => FabAlert(
          color: const Color(0xFFE4756D),
          icon: CupertinoIcons.clear_circled_solid,
          message: failure.message,
        ),
    };

    await _showToast(
      slideCurve: slideCurve,
      isClosable: isClosable,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      positionCurve: positionCurve,
      useSafeArea: useSafeArea,
      alignment: alignment,
      length: length,
      dismissDirection: dismissDirection,
      child: child,
    );
  }

  Future<void> showToast({
    String? message,
    TextStyle? messageStyle,
    Widget? leading,
    bool isClosable = false,
    double expandedHeight = 150,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.elasticOut,
    bool useSafeArea = true,
    ToastAlignment alignment = ToastAlignment.top,
    ToastLength length = ToastLength.short,
    ToastDismissDirection? dismissDirection,
  }) async {
    await _showToast(
      message: message,
      messageStyle: messageStyle,
      isClosable: isClosable,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      positionCurve: positionCurve,
      length: length,
      dismissDirection: dismissDirection,
      leading: leading,
      slideCurve: slideCurve,
      useSafeArea: useSafeArea,
      alignment: alignment,
    );
  }

  Future<void> showWidgetToast({
    Widget? child,
    bool isClosable = false,
    double expandedHeight = 150,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.elasticOut,
    bool useSafeArea = true,
    ToastAlignment alignment = ToastAlignment.top,
    ToastLength length = ToastLength.short,
    ToastDismissDirection? dismissDirection,
  }) async {
    await _showToast(
      slideCurve: slideCurve,
      isClosable: isClosable,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      positionCurve: positionCurve,
      useSafeArea: useSafeArea,
      alignment: alignment,
      length: length,
      dismissDirection: dismissDirection,
      child: child,
    );
  }

  Future<void> _showToast({
    String? message,
    TextStyle? messageStyle,
    Widget? leading,
    Widget? child,
    bool isClosable = false,
    double expandedHeight = 150,
    Color? backgroundColor,
    Color? shadowColor,
    Curve? slideCurve,
    Curve positionCurve = Curves.elasticOut,
    bool useSafeArea = true,
    ToastAlignment alignment = ToastAlignment.top,
    ToastLength length = ToastLength.medium,
    ToastDismissDirection? dismissDirection,
  }) async {
    assert(
      expandedHeight >= 0.0,
      'Expanded height should not be a negative number!',
    );

    assert(
      (alignment == ToastAlignment.top && dismissDirection != ToastDismissDirection.down) ||
          (alignment == ToastAlignment.bottom && dismissDirection != ToastDismissDirection.up) ||
          (dismissDirection == ToastDismissDirection.horizontal),
      'If ToastAlignment is top then ToastDismissDirection must not be down. If ToastAlignment is bottom then ToastDismissDirection must not be up.',
    );

    final context = _navigator.context;

    if (context != null && context.mounted) {
      _overlayState = Overlay.of(context);
      final controller = AnimationController(
        vsync: _overlayState!,
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 1000),
      );

      final toast = ToastModel(
        controller: controller,
      );

      final overlayEntry = OverlayEntry(
        builder: (_) => AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return ToastWrapper(
              controller: controller,
              alignment: alignment,
              useSafeArea: useSafeArea,
              expandedPositionedPadding: toast.position + (toast.isExpanded ? expandedHeight : 0.0),
              expandedPaddingHorizontal: (toast.isExpanded
                  ? 10
                  : math.max(
                      toast.position - 35,
                      0,
                    )),
              positionCurve: positionCurve,
              dismissDirection: dismissDirection ?? _getDefaultDismissDirection(dismissDirection, alignment),
              onDismissed: () {
                _removeOverlayEntry(toast);
                _updateOverlayPositions(true, toast);
              },
              animatedOpacity: _calculateOpacity(toast),
              child: Toast(
                message: message,
                messageStyle: messageStyle,
                backgroundColor: backgroundColor,
                shadowColor: shadowColor,
                curve: slideCurve,
                isClosable: isClosable,
                isInFront: _isToastInFront(toast),
                controller: controller,
                onTap: () => _toggleExpand(toast),
                onClose: () {
                  _removeOverlayEntry(toast);
                  _updateOverlayPositions(true, toast);
                },
                leading: leading,
                child: child,
              ),
            );
          },
        ),
      );

      toast.overlayEntry = overlayEntry;
      _overlays.add(toast);

      _updateOverlayPositions(false, toast);
      _forwardAnimation(toast);
      await Future.delayed(_toastDuration(length));
      _reverseAnimation(toast);
    }
  }

  void _reverseAnimation(ToastModel toast) {
    if (_overlays.contains(toast)) {
      toast.controller.reverse().then((_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        _removeOverlayEntry(toast);
      });
    }
  }

  void _removeOverlayEntry(ToastModel toast) {
    toast.dispose();
    _overlays.remove(toast);
  }

  void _forwardAnimation(ToastModel toast) {
    _overlayState?.insert(toast.overlayEntry!);
    toast.controller.forward();
  }

  double _calculateOpacity(ToastModel toast) {
    final noOfShowToast = _showMaxToast;
    if (_overlays.length <= noOfShowToast) {
      return 1;
    }

    final recentOverlays = _overlays.sublist(_overlays.length - noOfShowToast);

    return recentOverlays.contains(toast) ? 1 : 0;
  }

  bool _isToastInFront(ToastModel toast) {
    final noOfShowToast = _showMaxToast;

    return _overlays.indexOf(toast) >= _overlays.length - noOfShowToast;
  }

  void _updateOverlayPositions(bool isReverse, ToastModel toast) {
    if (isReverse) {
      _reverseUpdatePositions(toast);
    } else {
      _forwardUpdatePositions();
    }
  }

  void _rebuildPositions() {
    for (final overlayInfo in _overlays) {
      overlayInfo.overlayEntry?.markNeedsBuild();
    }
  }

  void _reverseUpdatePositions(ToastModel toast) {
    final currentIndex = _overlays.indexOf(toast);
    for (var i = currentIndex - 1; i >= 0; i--) {
      _overlays[i].position -= 10;
      _overlays[i].overlayEntry?.markNeedsBuild();
    }
  }

  void _forwardUpdatePositions() {
    for (final overlayInfo in _overlays) {
      overlayInfo.position += 10;
      overlayInfo.overlayEntry?.markNeedsBuild();
    }
  }

  void _toggleExpand(ToastModel toast) {
    toast.isExpanded = !toast.isExpanded;
    _rebuildPositions();
  }

  Duration _toastDuration(ToastLength length) {
    switch (length) {
      case ToastLength.short:
        return const Duration(milliseconds: 2000);
      case ToastLength.medium:
        return const Duration(milliseconds: 3500);
      case ToastLength.long:
        return const Duration(milliseconds: 5000);
      case ToastLength.ages:
        return const Duration(minutes: 2);
      default:
        return const Duration(hours: 24);
    }
  }
}
