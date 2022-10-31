import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

final testDevices = [
  Device.phone.copyWith(name: 'Small phone'),
  Device.iphone11.copyWith(name: 'iPhone 11'),
];

Future<void> prepareRequirements() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Loads app fonts to use them in golden test.
  await loadAppFonts();

  // Creates mock path_provider and flutter_secure_storage.
  const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler(
    (MethodCall methodCall) async => '.',
  );

  // Configures dependency injection to init modules and singletons.
  await configureDependencyInjection();
}

Future<void> prepareGoldenTests(FutureOr<void> Function() testMain) async {
  const isRunningInCi = bool.fromEnvironment('CI');

  return GoldenToolkit.runWithConfiguration(
    testMain,
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => isRunningInCi,
      defaultDevices: testDevices,
      enableRealShadows: true,
    ),
  );
}
