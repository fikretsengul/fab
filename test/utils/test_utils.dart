import 'dart:async';

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
