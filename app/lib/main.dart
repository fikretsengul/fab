// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/core/routing/routing.dart';
import 'package:deps/features/auth.dart';
import 'package:deps/locator/locator.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/path_provider.dart';
import 'package:flutter/material.dart' hide Router;

import 'pages/error.page.dart';
import 'router/pages.dart';

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
    // Provides the `AuthBloc` to the widget tree.
    BlocProvider(
      create: (_) => di<AuthBloc>(),
      child: Application(
        title: 'Flutter Advanced Boilerplate',
        theme: ThemeData.light(),
        router: Router(
          onRedirect: onRedirect,
          errorPage: ErrorPageWidget.delegate,
          refreshListenable: di<AuthBloc>().isAuthenticatedListenable(),
          pages: pages,
        ),
      ),
    ),
  );
}

/// Determines the redirect logic based on the authentication status and current route.
///
/// [context]: The build context.
/// [isAuthenticated]: A boolean indicating if the user is authenticated.
/// [info]: The `RouteInfo` object containing details about the current route.
///
/// Returns a string representing the path to redirect to, or null if no redirect is needed.
String? onRedirect(
  BuildContext context, {
  required bool isAuthenticated,
  required RouteInfo info,
}) {
  // Redirects to the login page if the user is not authenticated and not on the login page.
  if (!isAuthenticated && info.path != Pages.login.path) {
    return Pages.login.path;
  }

  // Redirects to the home page if the user is authenticated and on the login page.
  if (isAuthenticated && info.path == Pages.login.path) {
    return Pages.home.path;
  }

  // No redirection needed.
  return null;
}
