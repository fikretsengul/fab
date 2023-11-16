import 'package:deps/core/analytics/analytics.dart';
import 'package:deps/core/analytics/logger.dart';
import 'package:deps/core/routing/application.dart';
import 'package:deps/core/routing/router.dart';
import 'package:deps/core/storage/cache.dart';
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

  /// I don’t really like the code duplication implied by
  /// having multiple main_*.dart files. I prefer determining
  /// the environment at runtime using the package name & build
  /// flavors or adding --dart-define=flavor=prod and calling
  /// String.fromEnvironment('flavor') to initialize the locator.
  const env = String.fromEnvironment('flavor', defaultValue: 'dev');

  // Inits service locator.
  initLocator(env);

  // Inits hydrated bloc storage.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(
    BlocProvider(
      create: (_) => di<AuthBloc>(),
      child: ApplicationScope(
        analytics: di<Analytics>(),
        logger: di<Logger>(),
        cache: di<ICache>(),
        router: Router(
          onRedirect: onRedirect,
          errorPage: ErrorPageWidget.delegate,
          refreshListenable: di<AuthBloc>().isAuthenticatedListenable(),
          pages: pages,
        ),
        child: Application(
          title: 'Flutter Advanced Boilerplate',
          theme: ThemeData.light(),
        ),
      ),
    ),
  );
}

String? onRedirect(
  BuildContext context, {
  required bool isAuthenticated,
  required RouteInfo info,
}) {
  if (!isAuthenticated && info.path != Pages.login.path) {
    return Pages.login.path;
  }

  if (isAuthenticated && info.path == Pages.login.path) {
    return Pages.home.path;
  }

  return null;
}
