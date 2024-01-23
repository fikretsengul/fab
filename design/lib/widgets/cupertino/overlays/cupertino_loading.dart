import 'package:flutter/cupertino.dart';

class CupertinoLoading extends StatelessWidget {
  const CupertinoLoading({super.key});

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
