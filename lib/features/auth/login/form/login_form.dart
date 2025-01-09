import 'dart:io';

import 'package:reactive_forms/reactive_forms.dart';

FormGroup get loginForm => FormGroup({
      'username': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      if (Platform.isAndroid || Platform.isIOS) ...{
        'photo': FormControl<File>(),
      },
    });
