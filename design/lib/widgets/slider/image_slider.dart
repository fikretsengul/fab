import 'package:deps/features/features.dart';
import 'package:deps/packages/fpdart.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/app_theme.dart';
import '../image/fab_image.dart';
import '../shadow/fab_shadow_overlay.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({
    required this.images,
    this.pageController,
    this.onSelectedItemChanged,
    super.key,
  });

  final List<String> images;
  final PageController? pageController;
  final void Function(int index)? onSelectedItemChanged;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late final PageController _pageController = widget.pageController ?? PageController();
  int _selectedItemIndex = 0;
  bool _isInHero = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _selectedItemIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    if (widget.pageController == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FabGradientShadow(
          enabled: !_isInHero,
          shadowHeight: 60,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: widget.onSelectedItemChanged,
            itemBuilder: (context, index) {
              final image = widget.images.elementAt(index);

              return Hero(
                tag: image,
                transitionOnUserGestures: true,
                flightShuttleBuilder: (_, animation, __, fromHeroContext, toHeroContext) {
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
                child: FabImage(uri: image),
              );
            },
          ),
        ),
        Positioned(
          bottom: $.paddings.xs,
          child: AnimatedOpacity(
            opacity: _isInHero ? 0 : 1,
            duration: $.timings.mil400,
            child: Container(
              padding: $.paddings.xxs.all,
              decoration: BoxDecoration(
                color: context.appTheme.placeholderColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
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
                      color:
                          _selectedItemIndex == index ? context.appTheme.primaryColor : context.appTheme.surfaceColor,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
