import 'dart:io';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/utils/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_advanced_boilerplate/assets.dart';
import 'package:flutter_advanced_boilerplate/features/app/blocs/app_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_button.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_image_view.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/customs/custom_textfield.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/utils/keyboard_dismisser.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/utils/material_splash_tappable.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/form/login_form.dart';
import 'package:flutter_advanced_boilerplate/features/auth/login/presentation/components/intro_widget.dart';
import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/helpers/bar_helper.dart';
import 'package:flutter_advanced_boilerplate/utils/helpers/permission_helper.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:universal_platform/universal_platform.dart';

@RoutePage()
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
  final ImagePicker picker = ImagePicker();

  // late RoundedLoadingButtonController _btnController;
  late FormGroup _form;

  @override
  void initState() {
    // _btnController = RoundedLoadingButtonController();
    _form = widget.form ?? loginForm;
    super.initState();
  }

  File? get photo => _form.control('photo').value as File?;

  String get username => _form.control('username').value.toString();

  String get password => _form.control('password').value.toString();

  Future<void> checkPermission() async {
    final hasPermission = await checkPhotosPermission();

    if (hasPermission && mounted) {
      await selectPhoto();
    } else {
      if (mounted) {
        BarHelper.showAlert(
          context,
          alert: AlertModel(
            message: context.t.core.file_picker.no_permission,
            type: AlertType.destructive,
          ),
        );
      }
    }
  }

  Future<void> selectPhoto() async {
    const maxPhotoSizeInByte = 2000000;

    final photo =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (photo == null) {
      return;
    }

    final size = await photo.length();

    if (!mounted) {
      return;
    }

    if (size <= maxPhotoSizeInByte) {
      // Execute the upload operation with bloc for photo. For ex.
      // Create a form data and send a post request with dio in your repo.
      // FormData formData = FormData.fromMap({
      //   "image": await MultipartFile.fromFile(photo.path),
      // });
      _form.control('photo').value = File(photo.path);
    } else {
      BarHelper.showAlert(
        context,
        alert: AlertModel(
          message: context.t.core.file_picker
              .size_warning(maxSize: maxPhotoSizeInByte / 1000000),
          type: AlertType.destructive,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: widget.cubit ?? context.read<AuthCubit>(),
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            _form
              ..unfocus()
              ..markAsDisabled();
          },
          failed: (alert) {
            _form.markAsEnabled();
            BarHelper.showAlert(
              context,
              alert: alert,
              isTest: widget.cubit != null,
            );
          },
          authenticated: (_) {
            _form
              ..reset()
              ..markAsEnabled();

            if (widget.cubit != null) {
              BarHelper.showAlert(
                context,
                alert: AlertModel.alert(
                  message: context.t.core.test.succeded,
                  type: AlertType.constructive,
                ),
                isTest: true,
              );
            }
          },
          orElse: () {
            _form.markAsEnabled();
          },
        );
      },
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, s) {
          if (!s.introViewed) {
            return const IntroWidget();
          }
          return _buildFormWidget(context);
        },
      ),
    );
  }

  Widget _buildFormWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل دخول'),
      ),
      body: KeyboardDismisserWidget(
        child: ReactiveForm(
          formGroup: _form,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: $constants.insets.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  CustomTextField(
                    formControlName: 'username',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    labelText: context.t.core.form.username.label,
                    hintText: context.t.core.form.username.hint,
                    minLength: 4,
                    isRequired: true,
                  ),
                  10.verticalSpace,
                  ReactiveFormConsumer(
                    builder: (context, formGroup, child) {
                      return CustomTextField(
                        formControlName: 'password',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        obscureText: true,
                        labelText: context.t.core.form.password.label,
                        hintText: context.t.core.form.password.hint,
                        minLength: 4,
                        isRequired: true,
                        onSubmitted: _form.valid
                            ? (_) => BlocProvider.of<AuthCubit>(context).login(
                                  username: username,
                                  password: password,
                                )
                            : null,
                      );
                    },
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text('نسيت كلمة المرور؟')),
                  SizedBox(height: $constants.insets.sm),
                  ReactiveFormConsumer(
                    builder: (context, formGroup, child) => AsyncButtonBuilder(
                      builder: (context, child, callback, buttonState) =>
                          ElevatedButton(
                        onPressed: callback,
                        child: child,
                      ),
                      onPressed: _form.valid
                          ? () async =>
                              BlocProvider.of<AuthCubit>(context).login(
                                username: username,
                                password: password,
                              )
                          : null,
                      child: Text(context.t.login.login_button),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: CustomImageView(image: Assets.images.logo.provider()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
