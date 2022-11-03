import 'package:flutter_advanced_boilerplate/features/app/models/auth_model.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioTokenRefresh {
  DioTokenRefresh(this._secureStorage) {
    _fresh = Fresh<AuthModel>(
      tokenStorage: _secureStorage,
      refreshToken: (token, _) => _refreshToken(token),
      shouldRefresh: (response) {
        return response?.statusCode == 401;
      },
      tokenHeader: (token) {
        return {'authorization': '${token.tokenType} ${token.accessToken}'};
      },
    );
  }

  final TokenStorage<AuthModel> _secureStorage;
  late final Fresh<AuthModel> _fresh;

  Fresh<AuthModel> get fresh => _fresh;

  Future<AuthModel> _refreshToken(AuthModel? token) async {
    if (token == null) {
      throw RevokeTokenException();
    }

    try {
      // TODO -> Implement dio token refresh algorithm.

      return token;
    } catch (e) {
      throw RevokeTokenException();
    }
  }
}
