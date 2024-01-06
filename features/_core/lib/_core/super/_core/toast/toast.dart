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
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: widget.backgroundColor ?? Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: widget.isInFront ? 0.5 : 0.0,
                    offset: const Offset(0, -1),
                    color: widget.shadowColor ?? Colors.grey.shade400,
                  ),
                  BoxShadow(
                    blurRadius: widget.isInFront ? 12 : 3,
                    offset: const Offset(0, 7),
                    color: widget.shadowColor ?? Colors.grey.shade400,
                  ),
                ],
              ),
              child: (widget.child != null)
                  ? widget.child
                  : Row(
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
