// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/reactive_forms.dart';

class FormEmailValidator extends Validator<dynamic> {
  const FormEmailValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return Validators.email(control);
  }
}
