import 'package:commons/types.dart';

/// Types used by invoke network client.
enum RequestType { get, post, put, delete, patch }

// ignore: one_member_abstracts
abstract class INetworkClient {
  AsyncEither<T> invoke<T>(
    String url,
    RequestType requestType, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic requestBody,
  });
}
