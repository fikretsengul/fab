import 'package:reactive_forms/reactive_forms.dart';

FormGroup get loginForm => FormGroup({
      'username': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(5),
        ],
      ),
    });
