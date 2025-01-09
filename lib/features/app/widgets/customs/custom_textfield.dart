import 'package:flutter_advanced_boilerplate/i18n/strings.g.dart';
import 'package:flutter_advanced_boilerplate/utils/constants.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.formControlName,
    super.key,
    this.validationMessages,
    this.prefixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.hasCounter = false,
    this.hintText = '',
    this.labelText = '',
    this.extraInfo = '',
    this.maxLines = 1,
    this.minLines,
    this.minLength,
    this.maxLength,
    this.isRequired = false,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.staticValue = '',
    this.showErrors = true,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmitted,
    this.alignLabelWithHint = false,
    this.textAlignVertical = TextAlignVertical.center,
  }) : assert(
          !hasCounter || maxLength != null,
          'Max length must be provided when counter is active.',
        );
  final TextAlignVertical textAlignVertical;

  final bool alignLabelWithHint;

  final Map<String, String> Function(FormControl<Object?>)? validationMessages;
  final void Function(FormControl<Object?>)? onTap;
  final void Function(FormControl<Object?>)? onSubmitted;
  final String extraInfo;
  final String formControlName;
  final bool hasCounter;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String labelText;
  final int? maxLength;
  final int? maxLines;
  final int? minLength;
  final int? minLines;
  final bool obscureText;
  final bool readOnly;
  final bool showErrors;
  final String staticValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  InputDecoration getTextFieldDecoration(FormGroup form, BuildContext context) {
    return InputDecoration(
      alignLabelWithHint: widget.alignLabelWithHint,
      labelStyle:
          getTextTheme(context).titleSmall!.copyWith(color: Colors.grey[600]),
      errorMaxLines: 2,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon: widget.obscureText
          ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: showPassword
                  ? const Icon(Icons.visibility_off_rounded)
                  : const Icon(Icons.visibility_rounded),
            )
          : widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
        minWidth: 40,
        minHeight: 40,
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
        minWidth: 40,
        minHeight: 40,
      ),
      hintText: widget.hintText,
      labelText: widget.labelText,
      contentPadding: widget.labelText.isNotEmpty
          ? EdgeInsets.fromLTRB(
              $constants.insets.md - 4,
              $constants.insets.xs + 5,
              $constants.insets.lg + 5,
              $constants.insets.xs + 5,
            )
          : null,
    );
  }

  Widget? buildCounter(
    BuildContext context, {
    required int currentLength,
    int? maxLength,
  }) {
    return !widget.hasCounter
        ? const SizedBox()
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 1.5,
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  color: getCustomOnPrimaryColor(context).withOpacity(0.2),
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: Text(
              '$currentLength/$maxLength',
              style: getTextTheme(context).bodySmall,
            ),
          );
  }

  IconData getIcon(FormGroup form) {
    if (form.status != ControlStatus.disabled &&
        !form.control(widget.formControlName).valid) {
      return Icons.star;
    }

    return Icons.check;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            ReactiveTextField(
              showErrors: widget.showErrors ? null : (_) => false,
              controller: widget.staticValue.isNotEmpty
                  ? TextEditingController(text: widget.staticValue)
                  : null,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText && !showPassword,
              onTap: widget.onTap,
              formControlName: widget.formControlName,
              validationMessages: {
                ValidationMessage.minLength: (_) =>
                    Translations.of(context).core.errors.form.minLength(
                          field: widget.labelText,
                          count: widget.minLength.toString(),
                        ),
                ValidationMessage.maxLength: (_) =>
                    Translations.of(context).core.errors.form.maxLength(
                          field: widget.labelText,
                          count: widget.maxLength.toString(),
                        ),
                ValidationMessage.required: (_) => context.t.core.errors.form
                    .required(field: widget.labelText),
                ValidationMessage.mustMatch: (_) => 'كلمة السر غير متطابقة',
                ValidationMessage.email: (_) =>
                    context.t.core.errors.form.email,
              },
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              textAlignVertical: widget.textAlignVertical,
              minLines: widget.minLines,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              buildCounter: (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) {
                return buildCounter(
                  context,
                  currentLength: currentLength,
                  maxLength: maxLength,
                );
              },
              decoration: getTextFieldDecoration(form, context),
              inputFormatters: widget.inputFormatters,
              textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmitted,
            ),
            if (widget.extraInfo.isNotEmpty) ...{
              Padding(
                padding: EdgeInsets.only(
                  left: $constants.insets.xs,
                  top: $constants.insets.xs - 2,
                  bottom: $constants.insets.xs - 2,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      size: 16,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.extraInfo,
                          style: getTextTheme(context)
                              .bodySmall!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            },
          ],
        );
      },
    );
  }
}
