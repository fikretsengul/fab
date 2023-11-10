import 'package:deps/injectable.dart';
import 'package:envied/envied.dart';

import 'i_env.dart';

part 'env_dev.g.dart';

@Environment('dev')
@Singleton(as: IEnv)
@Envied(path: '../../../.env.dev')
class EnvDev implements IEnv {
  @override
  @EnviedField(varName: 'API_URL')
  final String analyticsUrl = _EnvDev.analyticsUrl;

  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String apiUrl = _EnvDev.apiUrl;

  @override
  final bool isDebug = true;
}
