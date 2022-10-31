import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

@isTest
void screenshotTest(
  String description, {
  String variantName = '',
  FutureOr<void> Function()? setUp,
  required Widget screen,
  Future<void> Function(WidgetTester)? customPump,
}) {
  return testGoldens(
    description,
    (tester) async {
      final builder = DeviceBuilder(
        bgColor: Colors.lightBlue,
      )..addScenario(
          name: variantName,
          widget: Builder(
            builder: (context) {
              setUp?.call();

              return screen;
            },
          ),
        );

      await tester.pumpDeviceBuilder(builder, wrapper: customAppWrapper());
      await screenMatchesGolden(
        tester,
        "$description${variantName.trim().isEmpty ? '' : ' $variantName'}",
        customPump: customPump ?? (tester) => tester.pump(const Duration(milliseconds: 500)),
      );
    },
  );
}

WidgetWrapper customAppWrapper({
  TargetPlatform platform = TargetPlatform.android,
  Iterable<LocalizationsDelegate<dynamic>>? localizations,
  NavigatorObserver? navigatorObserver,
  Iterable<Locale>? localeOverrides,
  ThemeData? theme,
}) {
  return (child) => TranslationProvider(
        child: MaterialApp(
          localizationsDelegates: localizations,
          supportedLocales: localeOverrides ?? const [Locale('en')],
          theme: theme?.copyWith(platform: platform),
          debugShowCheckedModeBanner: false,
          home: Material(child: child),
          navigatorObservers: [
            if (navigatorObserver != null) navigatorObserver,
          ],
        ),
      );
}
