// ignore_for_file: max_lines_for_file
// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/design/design.dart';
import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/core.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/path_provider.dart';
import 'package:flutter/material.dart' hide Router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determines the environment at runtime for configuring the app.
  // I don’t really like the code duplication implied by
  // having multiple main_*.dart files. I prefer determining
  // the environment at runtime using the package name & build
  // flavors or adding --dart-define=flavor=prod and calling
  // String.fromEnvironment('flavor') to initialize the locator.
  const env = String.fromEnvironment('flavor', defaultValue: 'dev');

  // Initializes the service locator with the determined environment.
  initLocator(env);

  // Initializes the storage for HydratedBloc, which allows state persistence across app restarts.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(
    InfrastructureI18nProvider(
      child: DesignI18nProvider(
        child: FeaturesI18nProvider(
          child: FeaturesApp(),
        ),
      ),
    ),
  );
}
