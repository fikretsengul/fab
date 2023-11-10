import '../enums/failure_enums.dart';

abstract class IFailure implements Exception {
  FailureType get type;

  FailureTag get tag;

  String get code;

  String get message;

  Exception? get exception;

  StackTrace? get stack;
}
