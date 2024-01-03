// ignore_for_file: max_lines_for_file

// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import '../../_core/enums/failure_tag_enum.dart';
import '../../analytics/failure/failure.dart';

class NoNetworkFailure extends Failure {
  NoNetworkFailure({super.exception, super.stack})
      : super(
          code: 'no-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'No network connection. Please check your internet connection and try again.',
        );
}

class TimeoutNetworkFailure extends Failure {
  TimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The network request timed out. Please check your connection and try again.',
        );
}

class BadRequestNetworkFailure extends Failure {
  BadRequestNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-request-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The request was not formatted correctly and could not be understood. Please check the request format and try again.',
        );
}

class UnauthorizedNetworkFailure extends Failure {
  UnauthorizedNetworkFailure({super.exception, super.stack})
      : super(
          code: 'unauthorized-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'Authentication is required and has failed or has not been provided. Please verify your credentials and try again.',
        );
}

class ForbiddenNetworkFailure extends Failure {
  ForbiddenNetworkFailure({super.exception, super.stack})
      : super(
          code: 'forbidden-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The request was valid, but the server is refusing action. Please check your permissions and try again.',
        );
}

class NotFoundNetworkFailure extends Failure {
  NotFoundNetworkFailure({super.exception, super.stack})
      : super(
          code: 'not-found-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The requested resource could not be found. Please check the URL and try again.',
        );
}

class RequestTimeoutNetworkFailure extends Failure {
  RequestTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The server timed out waiting for the request. Please attempt to reconnect and try again.',
        );
}

class TooManyRequestsNetworkFailure extends Failure {
  TooManyRequestsNetworkFailure({super.exception, super.stack})
      : super(
          code: 'too-many-requests-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The user has sent too many requests in a given amount of time. Please wait before trying again.',
        );
}

class InternalServerNetworkFailure extends Failure {
  InternalServerNetworkFailure({super.exception, super.stack})
      : super(
          code: 'internal-server-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The server encountered an unexpected condition that prevented it from fulfilling the request. Please try again later.',
        );
}

class ServerErrorNetworkFailure extends Failure {
  ServerErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'server-error-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The server encountered a condition which prevented it from fulfilling the request. Please try again later.',
        );
}

class ClientErrorNetworkFailure extends Failure {
  ClientErrorNetworkFailure({super.exception, super.stack})
      : super(
          code: 'client-error-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'A client error occurred. Please check the request and try again.',
        );
}

class ConnectionTimeoutNetworkFailure extends Failure {
  ConnectionTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The connection timed out while attempting to reach the server. Please check your network settings and try again.',
        );
}

class SendTimeoutNetworkFailure extends Failure {
  SendTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'send-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The request timed out while trying to send data. Please check your connection and try again.',
        );
}

class ReceiveTimeoutNetworkFailure extends Failure {
  ReceiveTimeoutNetworkFailure({super.exception, super.stack})
      : super(
          code: 'receive-timeout-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The server took too long to send a response. Please check your connection and try again.',
        );
}

class BadCertificateNetworkFailure extends Failure {
  BadCertificateNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-certificate-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: "The server certificate is not valid. Please check the server's security certificate and try again.",
        );
}

class BadResponseNetworkFailure extends Failure {
  BadResponseNetworkFailure({super.exception, super.stack})
      : super(
          code: 'bad-response-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message:
              'The server responded with an unexpected format or status code. Please check the response and try again.',
        );
}

class RequestCancelNetworkFailure extends Failure {
  RequestCancelNetworkFailure({super.exception, super.stack})
      : super(
          code: 'request-cancel-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'The request was cancelled. Please check your request and try again.',
        );
}

class ConnectionNetworkFailure extends Failure {
  ConnectionNetworkFailure({super.exception, super.stack})
      : super(
          code: 'connection-network-failure',
          type: FailureType.exception,
          tag: FailureTag.network,
          message: 'Failed to connect to the server. Please check your network connection and try again.',
        );
}
