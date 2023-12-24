import 'package:deps/infrastructure/commons.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/reactive_forms_annotations.dart';

part 'login.form.freezed.dart';
part 'login.form.g.dart';
part 'login.form.gform.dart';

@freezed
@Rf()
class LoginForm with _$LoginForm {
  factory LoginForm({
    @RfControl(
      validators: [
        RequiredValidator(),
        FormValidators.email,
      ],
    )
    required String email,
    @RfControl(
      validators: [
        RequiredValidator(),
      ],
    )
    required String password,
  }) = _LoginForm;

  factory LoginForm.fromJson(Map<String, dynamic> json) => _$LoginFormFromJson(json);

  factory LoginForm.empty() => LoginForm(email: '', password: '');

  LoginForm._();

  bool get isEmpty => this == LoginForm.empty();
}
