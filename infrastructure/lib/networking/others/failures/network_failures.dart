// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../../../analytics/failure/failure.dart';
import '../../../analytics/others/enums.dart';
import '../../../i18n/translations.g.dart';

class NoNetworkFailure extends Failure {
  NoNetworkFailure({super.exception, super.stack})
      : super(
          code: 'no-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.noNetwork,
        );
}

class TimeoutNetworkFailure extends Failure {
  TimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.timeout,
        );
}

class BadRequestNetworkFailure extends Failure {
  BadRequestNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-request-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.badRequest,
        );
}

class UnauthorizedNetworkFailure extends Failure {
  UnauthorizedNetworkFailure({super.exception, super.stack})
      : super(
          code: 'unauthorized-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.unauthorized,
        );
}

class ForbiddenNetworkFailure extends Failure {
  ForbiddenNetworkFailure({super.exception, super.stack})
      : super(
          code: 'forbidden-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.forbidden,
        );
}

class NotFoundNetworkFailure extends Failure {
  NotFoundNetworkFailure({super.exception, super.stack})
      : super(
          code: 'not-found-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.notFound,
        );
}

class RequestTimeoutNetworkFailure extends Failure {
  RequestTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.requestTimeout,
        );
}

class TooManyRequestsNetworkFailure extends Failure {
  TooManyRequestsNetworkFailure({super.exception, super.stack})
      : super(
          code: 'too-many-requests-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.tooManyRequests,
        );
}

class InternalServerNetworkFailure extends Failure {
  InternalServerNetworkFailure({super.exception, super.stack})
      : super(
          code: 'internal-server-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.internalServer,
        );
}

class ServerErrorNetworkFailure extends Failure {
  ServerErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'server-error-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.serverError,
        );
}

class ClientErrorNetworkFailure extends Failure {
  ClientErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'client-error-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'A client error occurred.',
        );
}

class ConnectionTimeoutNetworkFailure extends Failure {
  ConnectionTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.connectionTimeout,
        );
}

class SendTimeoutNetworkFailure extends Failure {
  SendTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'send-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.sendTimeout,
        );
}

class ReceiveTimeoutNetworkFailure extends Failure {
  ReceiveTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'receive-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.receiveTimeout,
        );
}

class BadCertificateNetworkFailure extends Failure {
  BadCertificateNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-certificate-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.badCertificate,
        );
}

class BadResponseNetworkFailure extends Failure {
  BadResponseNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-response-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.badResponse,
        );
}

class RequestCancelNetworkFailure extends Failure {
  RequestCancelNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-cancel-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.requestCancel,
        );
}

class ConnectionNetworkFailure extends Failure {
  ConnectionNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: tr.failures.network.connection,
        );
}
