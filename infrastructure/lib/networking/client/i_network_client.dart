// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../../analytics/others/typedefs.dart';
import '../../commons/enums/request_type_enum.dart';
import '../../storage/storages/token/token_storage_mixin.dart';
import '../models/o_auth2_token.model.dart';

/// `INetworkClient` is an abstract interface class defining the contract for a network client.
/// This interface specifies how network requests should be made within the application.
abstract interface class INetworkClient {
  /// Makes a network request of the specified type and returns the result wrapped in an `AsyncEither`.
  ///
  /// This method abstracts the complexities of network communication, providing a unified
  /// interface for making different types of requests.
  ///
  /// [T]: The expected return type of the response data.
  /// [url]: The URL endpoint for the network request.
  /// [requestType]: The type of HTTP request to make (GET, POST, etc.).
  /// [queryParameters]: Optional query parameters for the request.
  /// [headers]: Optional headers for the request.
  /// [requestBody]: Optional body data for the request.
  ///
  /// Returns an `AsyncEither<T>`, which is either a `Failure` or a successful response of type `T`.
  AsyncEither<T> invoke<T>(
    String path,
    RequestType requestType, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    dynamic requestBody,
  });

  TokenStorageMixin<OAuth2Token> get tokenStorage;
}
