import 'package:deps/flutter_dotenv.dart';
import 'package:deps/injectable.dart';

import 'i_env.dart';

@Environment('prod')
@Singleton(as: IEnv)
class EnvProd extends IEnv {
  @override
  String get analyticsUrl => dotenv.get(
        'ANALYTICS_URL_PROD',
        fallback: 'https://fallback.analytics.com/prod',
      );

  @override
  String get apiUrl => dotenv.get(
        'API_URL_PROD',
        fallback: 'https://fallback.mock.com/prod',
      );

  @override
  bool get isDebug => false;
}
