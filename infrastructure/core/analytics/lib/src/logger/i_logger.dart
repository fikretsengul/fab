abstract class ILogger {
  void log(
    String message, {
    dynamic data,
  });

  void constructive(String message);

  void destructive(String message);

  void exception(
    String message, {
    Exception? exception,
    StackTrace? stackTrace,
  });
}
