// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Toast extends StatefulWidget {
  const Toast({
    required this.onTap,
    required this.controller,
    super.key,
    this.isInFront = false,
    this.onClose,
    this.message,
    this.messageStyle,
    this.leading,
    this.child,
    this.isClosable,
    this.backgroundColor,
    this.shadowColor,
    this.curve,
  }) : assert((message != null || message != '') || child != null);

  final String? message;
  final TextStyle? messageStyle;
  final Widget? child;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? shadowColor;
  final AnimationController? controller;
  final bool isInFront;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final Curve? curve;
  final bool? isClosable;

  @override
  State<Toast> createState() => _ToastState();
}

class _ToastState extends State<Toast> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          InkWell(
            onTap: widget.onTap,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: widget.child ??
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (widget.leading != null) ...[
                        widget.leading!,
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      if (widget.message != null)
                        Expanded(
                          child: Text(
                            widget.message!,
                            style: widget.messageStyle,
                          ),
                        ),
                    ],
                  ),
                ),
          ),
          if (widget.isClosable ?? false)
            Positioned(
              top: 0,
              right: 16,
              bottom: 0,
              child: InkWell(
                onTap: widget.onClose,
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
