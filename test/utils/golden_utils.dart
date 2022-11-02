import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

@isTest
void screenshotTest<MC, S>(
  String description, {
  MockCubit<S>? cubit,
  S? initialState,
  S? finalState,
  FormGroup? form,
  void Function(FormGroup)? formAction,
  FutureOr<void> Function()? setUp,
  Future<void> Function(Key, WidgetTester)? widgetTest,
  required Widget Function(MC?, FormGroup?) screen,
  Future<void> Function(WidgetTester)? customPump,
}) {
  return testGoldens(
    description,
    (tester) async {
      final builder = DeviceBuilder(
        bgColor: Colors.lightBlue,
      )..addScenario(
          onCreate: widgetTest != null ? (key) => widgetTest(key, tester) : null,
          widget: Builder(
            builder: (context) {
              if (cubit != null && initialState != null) {
                whenListen(
                  cubit,
                  Stream.fromIterable(
                    [finalState ?? initialState],
                  ),
                  initialState: initialState,
                );
              }

              if (form != null) {
                formAction?.call(form);
              }

              setUp?.call();

              return screen(cast<MC>(cubit), form);
            },
          ),
        );

      await tester.pumpDeviceBuilder(builder, wrapper: customAppWrapper());
      await screenMatchesGolden(
        tester,
        description,
        customPump: customPump ?? (tester) => tester.pump(const Duration(milliseconds: 500)),
      );
    },
  );
}

MC? cast<MC>(dynamic mockCubit) => mockCubit is MC ? mockCubit : null;

Finder findNVerify(Key key, Finder matching, dynamic lookFor) {
  final found = find.descendant(
    of: find.byKey(key),
    matching: matching,
  );

  expect(found, lookFor);

  return found;
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
