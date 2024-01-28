import 'package:flutter/material.dart';

class ScrollCheckerWidget extends StatefulWidget {
  const ScrollCheckerWidget({
    required this.controller,
    required this.builder,
    super.key,
  });

  final ScrollController controller;
  final Widget Function(bool isScrollable) builder;

  @override
  State<ScrollCheckerWidget> createState() => _ScrollCheckerWidgetState();
}

class _ScrollCheckerWidgetState extends State<ScrollCheckerWidget> {
  late final ScrollController _scrollController;
  late bool _isScrollable;

  @override
  void initState() {
    _scrollController = widget.controller;

    _isScrollable = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isScrollable = _scrollController.position.maxScrollExtent > 0;
        print('oo abi amk $_isScrollable');
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(_isScrollable);
  }
}
