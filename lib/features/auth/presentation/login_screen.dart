import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_button.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_textfield.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/utils/keyboard_dismisser.dart';
import 'package:flutter_advanced_boilerplate/features/auth/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/auth/form/login_form.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/modules/dependency_injection/di.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/helpers/bar_helper.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_advanced_boilerplate/utils/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    @visibleForTesting this.cubit,
    @visibleForTesting this.form,
  });

  final AuthCubit? cubit;
  final FormGroup? form;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late RoundedLoadingButtonController _btnController;
  late FormGroup _form;

  @override
  void initState() {
    _btnController = RoundedLoadingButtonController();
    _form = widget.form ?? loginForm;
    super.initState();
  }

  String get username => _form.control('username').value.toString();
  String get password => _form.control('password').value.toString();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.cubit ?? getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              _form
                ..unfocus()
                ..markAsDisabled();
              _btnController.start();
            },
            fail: () {
              _form.markAsEnabled();
              _btnController.reset();

              BarHelper.showAlert(
                context,
                alert: AlertModel.alert(
                  message: context.t.core.test.failed,
                  type: AlertType.destructive,
                ),
                isTest: widget.cubit != null,
              );
            },
            success: () {
              _form
                ..reset()
                ..markAsEnabled();
              _btnController.reset();

              if (widget.cubit != null) {
                BarHelper.showAlert(
                  context,
                  alert: AlertModel.alert(
                    message: context.t.core.test.succeded,
                    type: AlertType.constructive,
                  ),
                  isTest: true,
                );
              } else {
                context.router.push(const MainNavigatorRoute());
              }
            },
            orElse: () {
              _form.markAsEnabled();
              _btnController.reset();
            },
          );
        },
        child: KeyboardDismisserWidget(
          child: ReactiveForm(
            formGroup: _form,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Constants.paddingXL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      formControlName: 'username',
                      keyboardType: TextInputType.text,
                      labelText: context.t.core.form.username.label,
                      hintText: context.t.core.form.username.hint,
                      minLength: 5,
                      isRequired: true,
                    ),
                    CustomTextField(
                      formControlName: 'password',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      labelText: context.t.core.form.password.label,
                      hintText: context.t.core.form.password.hint,
                      minLength: 5,
                      isRequired: true,
                    ),
                    const SizedBox(height: Constants.paddingM),
                    ReactiveFormConsumer(
                      builder: (context, formGroup, child) => CustomButton(
                        controller: _btnController,
                        width: getSize(context).width,
                        text: context.t.login.login_button,
                        onPressed: _form.valid
                            ? () => BlocProvider.of<AuthCubit>(context).login(
                                  username: username,
                                  password: password,
                                )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
