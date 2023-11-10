import 'package:deps/freezed_annotation.dart';

part 'o_auth2_token.freezed.dart';
part 'o_auth2_token.g.dart';

/// Standard OAuth2Token as defined by
/// https://www.oauth.com/oauth2-servers/access-tokens/access-token-response/
@freezed
class OAuth2Token with _$OAuth2Token {
  const factory OAuth2Token({
    /// The access token string as issued by the authorization server.
    required String accessToken,

    /// The type of token this is, typically just the string “bearer”.
    required String tokenType,

    /// If the access token expires, the server should reply
    /// with the duration of time the access token is granted for.
    required int expiresIn,

    /// Token which applications can use to obtain another access token.
    required String refreshToken,

    /// Application scope granted as defined in https://oauth.net/2/scope
    required String scope,
  }) = _OAuth2Token;

  factory OAuth2Token.empty() => const OAuth2Token(
        accessToken: '',
        tokenType: '',
        expiresIn: 3600,
        refreshToken: '',
        scope: '',
      );

  factory OAuth2Token.fromJson(Map<String, dynamic> json) => _$OAuth2TokenFromJson(json);
}
