import 'package:deps/core/theming/theming.dart';
import 'package:deps/design/design.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart' as widgetbook;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgetbook_generator.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

// use @App annotation
@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        AccessibilityAddon(),
        DeviceFrameAddon(
          devices: [
            Devices.android.onePlus8Pro,
            Devices.android.samsungGalaxyNote20Ultra,
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
          ],
          initialDevice: Devices.ios.iPhone13,
        ),
        InspectorAddon(enabled: true),
        ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light - Red',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.light,
                  brightness: Brightness.light,
                  colors: ThemeSettings.defaultTheme,
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark - Red',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.dark,
                  brightness: Brightness.dark,
                  colors: ThemeSettings.defaultTheme,
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Light - Blue',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.light,
                  brightness: Brightness.light,
                  colors: ThemeSettings.themes.elementAt(3),
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark - Blue',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.dark,
                  brightness: Brightness.dark,
                  colors: ThemeSettings.themes.elementAt(3),
                ),
              ),
            ),
          ],
          themeBuilder: (_, theme, child) {
            return Theme(
              data: theme,
              child: child,
            );
          },
        ),
        BuilderAddon(
          name: 'ScreenUtil',
          builder: (context, child) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              useInheritedMediaQuery: true,
              builder: (context, child) => child!,
              child: DottedBackground(
                shape: DotsShape.texture,
                child: Center(child: child),
              ),
            );
          },
        ),
      ],
    );
  }
}
