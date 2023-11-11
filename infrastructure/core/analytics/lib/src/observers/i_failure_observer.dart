import 'package:deps/core/commons/errors.dart';

abstract class IFailureObserver {
  void onFailure(Failure failure);
}
