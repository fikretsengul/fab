import 'dart:io';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:universal_platform/universal_platform.dart';

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
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...{
        'photo': FormControl<File>(),
      },
    });
