import 'package:deps/flutter_dotenv.dart';
import 'package:deps/injectable.dart';

import 'i_env.dart';

@Environment('dev')
@Singleton(as: IEnv)
class EnvDev extends IEnv {
  @override
  String get analyticsUrl => dotenv.get(
        'ANALYTICS_URL_DEV',
        fallback: 'https://fallback.analytics.com/dev',
      );

  @override
  String get apiUrl => dotenv.get(
        'API_URL_DEV',
        fallback: 'https://fallback.mock.com/dev',
      );

  @override
  bool get isDebug => true;
}
