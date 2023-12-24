import 'package:deps/packages/dio.dart';

import '../../../analytics/failure/i_failure.dart';

class DioFailure extends DioException {
  DioFailure({
    required this.failure,
    required super.requestOptions,
  }) : super(error: failure);

  final IFailure failure;
}
