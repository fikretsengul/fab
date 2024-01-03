import 'package:deps/packages/injectable.dart';

import '../../../storage/storages/i_storage.dart';
import '../../failures/network_errors.dart';
import '../../models/o_auth2_token.model.dart';
import 'interceptors/dio_token_refresh_interceptor.dart';

@lazySingleton
class DioTokenRefresh {
  DioTokenRefresh(this._storage) {
    _initializeInterceptor();
  }

  final IStorage<OAuth2Token> _storage;

  late final DioTokenRefreshInterceptor<OAuth2Token> _interceptor;

  /// Gets the configured TokenRefreshInterceptor instance for use with a Dio client.
  DioTokenRefreshInterceptor<OAuth2Token> get interceptor => _interceptor;

  /// Initializes the TokenRefreshInterceptor with specific behaviors for token refresh.
  void _initializeInterceptor() {
    _interceptor = DioTokenRefreshInterceptor<OAuth2Token>(
      tokenStorage: _storage,
      refreshToken: _refreshToken,
      tokenHeader: _buildTokenHeader,
    );
  }

  /// Refreshes the OAuth2Token.
  /// TODO: Implement the actual token refresh logic.
  Future<OAuth2Token> _refreshToken(OAuth2Token? token, _) async {
    if (token == null) {
      throw UnexpectedTokenRefreshNetworkError();
    }

    // Implement actual token refresh logic here
    // This should include making a network request to refresh the token
    // and returning the new token.

    return token; // Placeholder return. Replace with actual refreshed token.
  }

  /// Builds the authorization header using the token.
  Map<String, String> _buildTokenHeader(OAuth2Token token) {
    return {'Authorization': '${token.tokenType} ${token.accessToken}'};
  }
}
