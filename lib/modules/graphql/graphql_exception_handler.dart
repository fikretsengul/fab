import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

AlertModel graphQLExceptionHandler(OperationException result) {
  if (result.linkException != null) {
    final e = result.linkException;

    return e is NetworkException
        ? AlertModel.exception(exception: e)
        : AlertModel.exception(exception: Exception('An unknown graphql client link exception occured.'));
  }

  final errors = result.graphqlErrors;

  return createAlertModel(errors.first.extensions!['code'] as String);
}

AlertModel createAlertModel(String code) {
  var message = '';
  var translatable = false;

  switch (code) {
    case 'EXAMPLEx001':
      message = 'This is an example error.';
      break;
    case 'INTERNAL_SERVER_ERROR':
      message = t['core.errors.others.server_failure'] as String;
      translatable = true;
      break;
    default:
      message = t['core.errors.others.an_unknown_error'] as String;
      translatable = true;
      break;
  }

  return AlertModel.alert(
    message: message,
    translatable: translatable,
    type: AlertType.error,
  );
}
