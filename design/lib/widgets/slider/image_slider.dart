//ignore_for_file: proper_controller_dispose,

import 'package:deps/features/features.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:deps/packages/skeletonizer.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/fab_theme.dart';
import '../image/fab_image.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    required this.productId,
    required this.images,
    this.width,
    this.height,
    this.onSelectedItemChanged,
    this.topLeftChild,
    this.topRightChild,
    this.onPressed,
    super.key,
  });

  final int productId;
  final double? width;
  final double? height;
  final List<String> images;
  final ValueChanged<int>? onSelectedItemChanged;
  final Widget? topLeftChild;
  final Widget? topRightChild;
  final void Function(PageController pageController)? onPressed;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final PageController _pageController;
  int _selectedItemIndex = 0;
  bool _isInHero = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.05);
    _pageController.addListener(() {
      setState(() {
        _selectedItemIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (widget.images.isEmpty) ...{
              Container(
                decoration: BoxDecoration(
                  color: context.fabTheme.inactiveColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
              ),
            } else ...{
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: widget.onSelectedItemChanged,
                itemBuilder: (_, index) {
                  final image = widget.images.elementAt(index);

                  return FractionallySizedBox(
                    widthFactor: 1 / _pageController.viewportFraction,
                    child: Hero(
                      tag: image + widget.productId.toString(),
                      transitionOnUserGestures: true,
                      flightShuttleBuilder: (_, animation, __, ___, toHeroContext) {
                        animation.addStatusListener((status) {
                          if (status == AnimationStatus.dismissed) {
                            setState(() {
                              _isInHero = false;
                            });
                          } else {
                            setState(() {
                              _isInHero = true;
                            });
                          }
                        });

                        return toHeroContext.widget;
                      },
                      child: FabImage(
                        uri: image,
                        pressedOpacity: 1,
                        onPressed: () => widget.onPressed?.call(_pageController),
                      ),
                    ),
                  );
                },
              ),
            },
            Positioned(
              bottom: $.paddings.xs,
              child: AnimatedOpacity(
                opacity: _isInHero ? 0 : 1,
                duration: $.timings.mil400,
                child: Container(
                  padding: $.paddings.xxs.all,
                  decoration: BoxDecoration(
                    color: context.fabTheme.onBackgroundColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.mapWithIndex((_, index) {
                      return Container(
                        width: 5,
                        height: 5,
                        margin: $.paddings.xxs.horizontal,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _selectedItemIndex == index
                              ? context.fabTheme.surfaceColor
                              : context.fabTheme.inactiveColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            if (widget.topLeftChild != null) ...{
              Positioned(
                left: $.paddings.xs,
                top: $.paddings.xs,
                child: AnimatedOpacity(
                  opacity: _isInHero ? 0 : 1,
                  duration: $.timings.mil400,
                  child: widget.topLeftChild,
                ),
              ),
            },
            if (widget.topRightChild != null) ...{
              Positioned(
                right: $.paddings.xs,
                top: $.paddings.xs,
                child: AnimatedOpacity(
                  opacity: _isInHero ? 0 : 1,
                  duration: $.timings.mil400,
                  child: widget.topRightChild,
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
