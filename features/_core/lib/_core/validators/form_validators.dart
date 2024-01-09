// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'form_email_validator.dart';

@immutable
final class FormValidators {
  static const email = FormEmailValidator();
}
