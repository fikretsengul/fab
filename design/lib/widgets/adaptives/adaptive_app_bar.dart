/* // ignore_for_file: avoid_returning_widgets
import 'package:deps/features/features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppBarStyle { material, cupertino, adaptive }

enum AppBarMode { normal, sliver }

class AdaptiveAppBar extends StatelessWidget {
  const AdaptiveAppBar._({
    required this.style,
    required this.mode,
    required this.title,
    super.key,
  });

  factory AdaptiveAppBar.material({
    required AppBarMode mode,
    required String title,
    Key? key,
  }) =>
      AdaptiveAppBar._(
        style: AppBarStyle.material,
        mode: mode,
        title: title,
        key: key,
      );

  factory AdaptiveAppBar.cupertino({
    required AppBarMode mode,
    required Widget title,
    Key? key,
  }) =>
      AdaptiveAppBar._(
        style: AppBarStyle.cupertino,
        mode: mode,
        title: title,
        key: key,
      );

  factory AdaptiveAppBar.adaptive({
    required AppBarMode mode,
    required Widget title,
    Key? key,
  }) =>
      AdaptiveAppBar._(
        style: AppBarStyle.adaptive,
        mode: mode,
        title: title,
        key: key,
      );

  final AppBarStyle style;
  final AppBarMode mode;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isIOS = style == AppBarStyle.cupertino || (style == AppBarStyle.adaptive && $.platform.isIOS);

    if (mode == AppBarMode.sliver) {
      return isIOS ? _buildCupertinoSliverAppBar() : _buildMaterialSliverAppBar();
    } else {
      return isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();
    }
  }

  AppBar _buildMaterialAppBar() {
    return AppBar(
      title: Text(title),
    );
  }

  AppBar _buildCupertinoAppBar() {
    return AppBar(
      title: Text(title),
      surfaceTintColor: const Color.fromARGB(0, 2, 1, 1),
      shadowColor: CupertinoColors.darkBackgroundGray,
      scrolledUnderElevation: .1,
      toolbarHeight: 44,
    );
  }

  SliverAppBar _buildMaterialSliverAppBar() {
    return SliverAppBar.large(
      title: title,
      // Other Material-specific properties for SliverAppBar
    );
  }

  CupertinoSliverNavigationBar _buildCupertinoSliverAppBar() {
    return CupertinoSliverNavigationBar(
      largeTitle: title,
      backgroundColor: Colors.transparent,
      border: null,
      shadowColor: CupertinoColors.darkBackgroundGray,
    );
  }
}
 */
