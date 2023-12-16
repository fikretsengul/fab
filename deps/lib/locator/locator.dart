import 'package:auth/_di/_di.dart';
import 'package:infrastructure/_di/_di.dart';

import '../packages/get_it.dart';
import '../packages/injectable.dart';
import 'locator.config.dart';

/// Global instance of [GetIt] for dependency injection.
final GetIt di = GetIt.instance;

/// Initializes the service locator [GetIt] with infrastructure and feature dependencies.
///
/// This function configures [GetIt] to provide dependencies for different layers of the application.
/// It initializes dependencies for both infrastructure and features.
///
/// [env] is a string representing the current environment (e.g., development, production).
@InjectableInit(initializerName: 'init')
void initLocator(String env) {
  // Inject infrastructure-level dependencies.
  injectInfrastructure(di, env);

  // Inject feature-level dependencies.
  injectAuthFeature(di, env);

  // Finalize the initialization of dependencies.
  di.init(environment: env);
}
