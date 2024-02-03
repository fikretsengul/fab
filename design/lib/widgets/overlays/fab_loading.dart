import 'package:flutter/cupertino.dart';

class FabLoading extends StatelessWidget {
  const FabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 30,
        color: CupertinoTheme.of(context).primaryContrastingColor,
      ),
    );
  }
}
