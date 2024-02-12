import 'package:flutter/material.dart';

class FabKeepChildAlive extends StatefulWidget {
  const FabKeepChildAlive({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<FabKeepChildAlive> createState() => _FabKeepChildAliveState();
}

class _FabKeepChildAliveState extends State<FabKeepChildAlive> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
