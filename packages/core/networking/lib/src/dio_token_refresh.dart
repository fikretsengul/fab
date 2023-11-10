import 'package:deps/injectable.dart';
import 'package:storage/storage.dart';

import 'interceptors/token_refresh_interceptor.dart';
import 'token/o_auth2_token.dart';

@lazySingleton
class DioTokenRefresh {
  DioTokenRefresh(this._storage) {
    interceptor = TokenRefreshInterceptor<OAuth2Token>(
      tokenStorage: _storage,
      refreshToken: (token, client) async {
        if (token == null) {
          throw RevokeTokenException();
        }

        // TODO -> Implement dio token refresh algorithm.

        return token;
      },
      tokenHeader: (token) {
        return {'authorization': '${token.tokenType} ${token.accessToken}'};
      },
    );
  }

  late final TokenRefreshInterceptor<OAuth2Token> interceptor;

  final IStorage<OAuth2Token> _storage;
}
