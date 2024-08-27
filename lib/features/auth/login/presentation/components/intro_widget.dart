import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_advanced_boilerplate/assets.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_image_view.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int currentIndex = 0;
  int max = 2;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: getTheme(context).primary,
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Stack(
                children: [
                  _floatingStick(start: -0.5.sw, thickness: 2),
                  _floatingStick(thickness: 1, start: -1.sw),
                  _floatingStick(thickness: 1, start: -0.4.sw)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CustomImageView(
                    image: Images.logo,
                    height: 60,
                    fit: BoxFit.contain,
                  ).animate().blur(
                        begin: const Offset(105, 5),
                        end: Offset.zero,
                        delay: 0.5.seconds,
                        duration: 800.milliseconds,
                      ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      controller: _pageController,
                      children: [
                        _buildIntroPage(
                          'معاً نحافظ علي سلامة الطرق',
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص.',
                        ),
                        _buildIntroPage(
                          'خلّك جزء من حل مشاكل الطرق في منطقتك.',
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص.',
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 1.5.seconds, duration: 800.milliseconds),
                  ),
                  const SizedBox(height: 80),
                  _buildControlButtons()
                      .animate()
                      .fadeIn(delay: 2.5.seconds, duration: 800.milliseconds)
                      .slideY(delay: 2.5.seconds, duration: 800.milliseconds),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingStick({double thickness = 2, double? start}) {
    return Transform.rotate(
      angle: 150 / pi,
      child: Container(
        height: 0.4.sh,
        width: thickness,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .slideX(
          begin: 0.1.sw,
          end: start ?? -0.2.sw,
          duration: 500.milliseconds,
        )
        .slideX(
          begin: 0,
          end: 0.5.sw,
          duration: 10.seconds,
          delay: 500.milliseconds,
        );
  }

  Widget _buildIntroPage(String title, String body) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: getTextTheme(context).titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              body,
              textAlign: TextAlign.center,
              style: getTextTheme(context).titleSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ).animate().fadeIn(duration: 800.milliseconds),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < max; i++)
              AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: currentIndex == i ? Colors.white : Colors.grey[600],
                ),
                duration: 800.milliseconds,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: currentIndex == i ? 6 : 15,
                width: 6,
                padding: EdgeInsets.zero,
              ),
          ],
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            if (currentIndex < max - 1) {
              _pageController.nextPage(
                duration: 800.milliseconds,
                curve: Curves.easeInOut,
              );
            } else {
              context.read<AppCubit>().setIntroViewed(introViewed: true);
            }
          },
          child: const Text('التالي'),
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .slide(
                begin: Offset(0, 0.1),
                end: Offset.zero,
                duration: 1200.milliseconds),
      ],
    );
  }
}
