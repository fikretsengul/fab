/* import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../containers/fab_container.dart';

class FabBottomNavbar extends StatefulWidget {
  const FabBottomNavbar({
    required this.icons,
    required this.initialIconColor,
    required this.navBarColor,
    required this.onIconTap,
    required this.autoHideOnScroll,
    required this.scrollController,
    super.key,
    this.isFloating = false,
    //this.autoHide = false,
    this.floatingHeight,
    this.floatingWidth,
    this.stackedHeight,
    this.stackedWidth,
    this.isSelectedColor = Colors.black,
    this.autoHideDuration = 300, // Default value is true
  });

  final List<IconData> icons;
  final Function(int) onIconTap;
  final bool isFloating;
  //final bool autoHide;
  final double? floatingHeight;
  final double? floatingWidth;
  final double? stackedHeight;
  final double? stackedWidth;
  final Color initialIconColor;
  final Color navBarColor;
  final Color? isSelectedColor;
  final bool autoHideOnScroll; // New parameter for auto hide
  final ScrollController scrollController;
  final int? autoHideDuration;

  @override
  State<FabBottomNavbar> createState() => _FabBottomNavbarState();
}

class _FabBottomNavbarState extends State<FabBottomNavbar> {
  int _currentIndex = 0;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.autoHideOnScroll) {
      // Attach a listener to the ScrollController to handle scrolling events
      widget.scrollController.addListener(_handleScroll);
    }
  }

  @override
  void dispose() {
    if (widget.autoHideOnScroll) {
      // Clean up the ScrollController when the widget is disposed
      widget.scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScroll() {
    // Calculate the scroll direction
    final scrollDown = widget.scrollController.position.userScrollDirection == ScrollDirection.forward;
    if (scrollDown != _isVisible) {
      setState(() {
        // Set the visibility state based on the scroll direction
        _isVisible = scrollDown;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavWidget = Wrap(
      children: [
        Padding(
          padding: widget.isFloating ? const EdgeInsets.only(left: 14, right: 14, bottom: 25) : EdgeInsets.zero,
          child: FabContainer(
            height:
                widget.isFloating ? MediaQuery.of(context).size.height / 11 : MediaQuery.of(context).size.height / 9,
            borderColor: widget.isFloating ? Colors.black : Colors.transparent,
            color: widget.navBarColor,
            shadowColor: widget.isFloating ? Colors.black : Colors.transparent,
            offset: const Offset(-1, -4),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < widget.icons.length; i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = i;
                        });
                        widget.onIconTap(i);
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              color: _currentIndex == i ? widget.isSelectedColor : Colors.transparent,
                              width: 100,
                              height: 100,
                              child: Icon(
                                widget.icons[i],
                                size: 40,
                                color: _currentIndex == i
                                    ? const Color.fromARGB(255, 190, 169, 224)
                                    : widget.initialIconColor,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                alignment: Alignment.bottomRight,
                                curve: Curves.easeIn,
                                width: _currentIndex == i ? 0 : 100,
                                height: _currentIndex == i ? 0 : 100,
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.autoHideOnScroll) {
      setState(() {
        bottomNavWidget = AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: widget.autoHideDuration!),
          child: bottomNavWidget,
        );
      });
      // Wrap the widget with AnimatedOpacity based on autoHideOnScroll parameter
    }

    return bottomNavWidget;
  }
}
 */
