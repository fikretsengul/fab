// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_returning_widgets

import 'package:flutter/material.dart';

import '../../contexts/toast_context.dart';

class ToastWrapper extends StatefulWidget {
  const ToastWrapper({
    required this.controller,
    required this.useSafeArea,
    required this.alignment,
    required this.expandedPositionedPadding,
    required this.expandedPaddingHorizontal,
    required this.positionCurve,
    required this.dismissDirection,
    required this.onDismissed,
    required this.animatedOpacity,
    required this.child,
    super.key,
  });

  final AnimationController controller;
  final bool useSafeArea;
  final ToastAlignment alignment;
  final double expandedPositionedPadding;
  final ToastDismissDirection dismissDirection;
  final Curve positionCurve;
  final VoidCallback onDismissed;
  final double expandedPaddingHorizontal;
  final double animatedOpacity;
  final Widget child;

  @override
  State<ToastWrapper> createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper> {
  final GlobalKey _childKey = GlobalKey();
  double _widgetHeight = 0;
  bool _isHeightCalculated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateChildHeight());
  }

  void _calculateChildHeight() {
    final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _widgetHeight = renderBox.size.height;
        _isHeightCalculated = true;
      });
    }
  }

  DismissDirection _mapToastDismissToDismissDirection() {
    switch (widget.dismissDirection) {
      case ToastDismissDirection.up:
        return DismissDirection.up;
      case ToastDismissDirection.down:
        return DismissDirection.down;
      case ToastDismissDirection.horizontal:
        return DismissDirection.horizontal;
      default:
        return DismissDirection.up;
    }
  }

  double get _safeAreaPadding {
    if (widget.useSafeArea) {
      return _isTopAligned ? MediaQuery.paddingOf(context).top : MediaQuery.paddingOf(context).bottom;
    } else {
      return 0;
    }
  }

  bool get _isTopAligned => widget.alignment == ToastAlignment.top;
  double get _mediaQueryHeight => MediaQuery.sizeOf(context).height;
  Offset get _offset => Offset(
        0,
        (_widgetHeight + widget.expandedPositionedPadding + _safeAreaPadding) /
            _mediaQueryHeight *
            (_isTopAligned ? -1 : 1),
      );
  Tween<Offset> get _position => Tween<Offset>(begin: _offset, end: Offset.zero);

  Widget _buildDismissibleContent() {
    return Dismissible(
      key: UniqueKey(),
      direction: _mapToastDismissToDismissDirection(),
      onDismissed: (_) => widget.onDismissed(),
      child: AnimatedPadding(
        padding: EdgeInsets.symmetric(horizontal: widget.expandedPaddingHorizontal),
        duration: const Duration(milliseconds: 500),
        curve: widget.positionCurve,
        child: AnimatedOpacity(
          opacity: widget.animatedOpacity,
          duration: const Duration(milliseconds: 500),
          child: SizedBox(key: _childKey, child: widget.child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !_isHeightCalculated,
      child: SlideTransition(
        position: _position.animate(
          CurvedAnimation(
            parent: widget.controller,
            curve: widget.positionCurve,
            reverseCurve: widget.positionCurve,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: _isTopAligned ? widget.expandedPositionedPadding + _safeAreaPadding : null,
              bottom: !_isTopAligned ? widget.expandedPositionedPadding + _safeAreaPadding : null,
              left: 10,
              right: 10,
              duration: const Duration(milliseconds: 500),
              curve: widget.positionCurve,
              child: _buildDismissibleContent(),
            ),
          ],
        ),
      ),
    );
  }
}
