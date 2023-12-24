import 'package:deps/packages/reactive_forms.dart';

class FormEmailValidator extends Validator<dynamic> {
  const FormEmailValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return Validators.email(control);
  }
}
