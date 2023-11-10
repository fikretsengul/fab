/// Standard OAuth2Token as defined by
/// https://www.oauth.com/oauth2-servers/access-tokens/access-token-response/
class OAuth2Token {
  const OAuth2Token({
    required this.accessToken,
    this.tokenType = 'bearer',
    this.expiresIn,
    this.refreshToken,
    this.scope,
  });

  /// The access token string as issued by the authorization server.
  final String accessToken;

  /// If the access token expires, the server should reply
  /// with the duration of time the access token is granted for.
  final int? expiresIn;

  /// Token which applications can use to obtain another access token.
  final String? refreshToken;

  /// Application scope granted as defined in https://oauth.net/2/scope
  final String? scope;

  /// The type of token this is, typically just the string “bearer”.
  final String? tokenType;
}
