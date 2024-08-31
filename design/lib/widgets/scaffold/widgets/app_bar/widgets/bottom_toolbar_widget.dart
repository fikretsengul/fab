import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/measures.dart';

class BottomToolbarWidget extends StatelessWidget {
  const BottomToolbarWidget({
    required this.measures,
    required this.toolbar,
    required this.color,
    super.key,
  });

  final Measures measures;
  final KeyedSubtree toolbar;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: measures.getSearchBarFocusAnimDur,
      height: measures.bottomToolbarHeight,
      color: color,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            height: measures.bottomToolbarHeight,
            bottom: 0,
            left: 0,
            right: 0,
            child: toolbar,
          ),
        ],
      ),
    );
  }
}
