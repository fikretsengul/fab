import 'package:deps/packages/injectable.dart';
import 'package:envied/envied.dart';

import 'i_env.dart';

part 'env_prod.g.dart';

@Environment('prod')
@Singleton(as: IEnv)
@Envied(path: '../../../.env.prod')
class EnvProd implements IEnv {
  @override
  @EnviedField(varName: 'API_URL')
  final String analyticsUrl = _EnvProd.analyticsUrl;

  @override
  @EnviedField(varName: 'ANALYTICS_URL')
  final String apiUrl = _EnvProd.apiUrl;

  @override
  final bool isDebug = true;
}
