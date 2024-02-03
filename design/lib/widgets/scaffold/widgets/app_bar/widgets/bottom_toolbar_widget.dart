import 'package:flutter/cupertino.dart';

import '../../../utils/measures.dart';

class BottomToolbarWidget extends StatelessWidget {
  const BottomToolbarWidget({
    required this.measures,
    required this.appbarBottom,
    required this.color,
    super.key,
  });

  final KeyedSubtree appbarBottom;
  final Color color;
  final Measures measures;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: measures.searchBarAnimationDuration,
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
            child: appbarBottom,
          ),
        ],
      ),
    );
  }
}
