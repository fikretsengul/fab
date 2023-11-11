import 'dart:async';

import 'package:deps/core/commons/enums.dart';

import '../i_storage.dart';

/// A mixin which handles core token refresh functionality.
mixin TokenStorageMixin<T> {
  AuthStatus _authStatus = AuthStatus.initial;
  final StreamController<AuthStatus> _controller = StreamController<AuthStatus>.broadcast()..add(AuthStatus.initial);

  T? _token;
  late IStorage<T> _tokenStorage;

  /// Setter for the [IStorage] instance.
  set tokenStorage(IStorage<T> tokenStorage) {
    _tokenStorage = tokenStorage..read().then(_updateStatus);
  }

  /// Returns the current token.
  Future<T?> get token async {
    if (_authStatus != AuthStatus.initial) {
      return _token;
    }
    await authStatus.first;
    return _token;
  }

  /// Returns a [Stream<AuthenticationStatus>] which can be used to get notified
  /// of changes to the authentication state based on the presence/absence of a token.
  Stream<AuthStatus> get authStatus async* {
    yield _authStatus;
    yield* _controller.stream;
  }

  /// Sets the internal [token] to the provided [token]
  /// and updates the [AuthStatus] accordingly.
  ///
  /// If the provided token is null, the [AuthStatus] will be updated
  /// to `unauthenticated` and the token will be removed from storage, otherwise
  /// it will be updated to `authenticated`and save to storage.
  Future<void> setToken(T? token) async {
    if (token == null) {
      return clearToken();
    }
    await _tokenStorage.write(token);
    _updateStatus(token);
  }

  /// Delete the storaged [token]. and emit the
  /// `AuthenticationStatus.unauthenticated` if authenticationStatus
  /// not is `AuthenticationStatus.unauthenticated`
  /// This method should be called when the token is no longer valid.
  Future<void> revokeToken() async {
    await _tokenStorage.delete();
    if (_authStatus != AuthStatus.unauthenticated) {
      _authStatus = AuthStatus.unauthenticated;
      _controller.add(_authStatus);
    }
  }

  /// Clears token storage and updates the [AuthStatus]
  /// to [AuthStatus.unauthenticated].
  Future<void> clearToken() async {
    await _tokenStorage.delete();
    _updateStatus(null);
  }

  /// Closes StreamController.
  ///
  /// [setToken] and [clearToken] must not be called after this method.
  ///
  /// Calling this method more than once is allowed, but does nothing.
  Future<void> close() => _controller.close();

  /// Update the internal [token] and updates the
  /// [AuthStatus] accordingly.
  ///
  /// If the provided token is null, the [AuthStatus] will
  /// be updated to `AuthenticationStatus.unauthenticated` otherwise it
  /// will be updated to `AuthenticationStatus.authenticated`.
  void _updateStatus(T? token) {
    _authStatus = token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    _token = token;
    _controller.add(_authStatus);
  }
}
