import 'package:commons/errors.dart';

abstract class IFailureObserver {
  void onFailure(Failure failure);
}
