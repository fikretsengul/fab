import 'package:deps/design/design.dart';
import 'package:deps/packages/widgetbook.dart';
import 'package:deps/packages/widgetbook_annotation.dart' as widgetbook;
import 'package:flutter/material.dart';

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
/*         ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light - Red',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.light,
                  brightness: Brightness.light,
                  colors: ThemeSettingsdefaultTheme,
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark - Red',
              data: createTheme(
                CustomTheme.custom(
                  mode: ThemeMode.dark,
                  brightness: Brightness.dark,
                  colors: ThemeSettingsdefaultTheme,
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
        ), */
        BuilderAddon(
          name: 'Builder',
          builder: (_, child) {
            return DottedBackground(
              shape: DotsShape.texture,
              child: Center(child: child),
            );
          },
        ),
      ],
    );
  }
}
