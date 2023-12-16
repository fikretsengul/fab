part of '_di.dart';

/// A module to provide [Talker] instance for dependency injection.
///
/// [Talker] is used for logging purposes in the application.
@module
abstract class TalkerModule {
  /// Provides a singleton instance of [Talker] initialized using [TalkerFlutter.init].
  Talker talker() => TalkerFlutter.init();
}

/// A module to provide [Dio] instance for dependency injection.
///
/// [Dio] is a powerful HTTP client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout, etc.
@module
abstract class DioModule {
  /// Provides a singleton instance of [Dio].
  Dio get dio => Dio();
}

/// A module to provide [InternetConnection] instance for dependency injection.
///
/// [InternetConnection] is used for checking internet connectivity in the application.
@module
abstract class InternetConnectionModule {
  /// Provides a singleton instance of [InternetConnection].
  InternetConnection get internetConnection => InternetConnection();
}

/// A module to provide [FlutterSecureStorage] instance for dependency injection.
///
/// [FlutterSecureStorage] is used for securely storing data in the app.
@module
abstract class FlutterSecureStorageModule {
  /// Provides a singleton instance of [FlutterSecureStorage] with Android options set for encrypted shared preferences.
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );
}
