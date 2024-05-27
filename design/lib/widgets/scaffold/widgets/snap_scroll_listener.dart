// ignore_for_file: avoid_nested_if
import 'package:flutter/material.dart';

import '../models/fab_appbar_search_bar_settings.dart';

class SnappingScrollListener extends StatefulWidget {
  SnappingScrollListener({
    required this.scrollBehavior,
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.child,
    this.scrollController,
    super.key,
  });

  final ScrollController? scrollController;
  final SearchBarScrollBehavior scrollBehavior;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  @override
  State<SnappingScrollListener> createState() => _SnappingScrollListenerState();
}

class _SnappingScrollListenerState extends State<SnappingScrollListener> {
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final currentScrollingPosition = widget.scrollController!.offset;

        if (widget.scrollBehavior == SearchBarScrollBehavior.floated) {
          final snapPoint1 = widget.collapsedHeight / 2;
          final snapPoint2 = widget.collapsedHeight + widget.expandedHeight / 2;

          if (notification is ScrollEndNotification && !_isAnimating) {
            if (currentScrollingPosition > 0 && currentScrollingPosition < snapPoint1) {
              _snapTo(0);
            } else if (currentScrollingPosition >= snapPoint1 && currentScrollingPosition < widget.collapsedHeight) {
              _snapTo(widget.collapsedHeight);
            } else if (currentScrollingPosition >= widget.collapsedHeight && currentScrollingPosition < snapPoint2) {
              _snapTo(widget.collapsedHeight);
            } else if (currentScrollingPosition >= snapPoint2 &&
                currentScrollingPosition < widget.collapsedHeight + widget.expandedHeight) {
              _snapTo(widget.collapsedHeight + widget.expandedHeight);
            }
          }
        } else if (widget.scrollBehavior == SearchBarScrollBehavior.pinned) {
          final snapPoint1 = widget.expandedHeight / 2;

          if (notification is ScrollEndNotification && !_isAnimating) {
            if (currentScrollingPosition < snapPoint1) {
              _snapTo(0);
            } else if (currentScrollingPosition >= snapPoint1 && currentScrollingPosition < widget.expandedHeight) {
              _snapTo(widget.expandedHeight);
            }
          }
        }

        return false;
      },
      child: widget.child,
    );
  }

  void _snapTo(double position) {
    setState(() {
      _isAnimating = true;
    });

    Future.delayed(Duration.zero, () {
      widget.scrollController!
          .animateTo(
        position,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      )
          .whenComplete(() {
        setState(() {
          _isAnimating = false;
        });
      });
    });
  }
}
