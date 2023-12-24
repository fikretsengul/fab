import 'package:flutter/foundation.dart';

import '../validators/form_email_validator.dart';

@immutable
final class FormValidators {
  static const email = FormEmailValidator();
}
