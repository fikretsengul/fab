// ignore_for_file: max_lines_for_file, prefer_underscore_for_unused_callback_parameters

import 'package:deps/features/features.dart';
import 'package:deps/packages/reactive_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_core/reactives/reactive_cupertino_textfield.dart';

class CupertinoTextfield extends StatelessWidget {
  const CupertinoTextfield({
    required this.formControl,
    required this.labelText,
    this.autofocus = false,
    this.borderRadius,
    this.validationMessages,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.hasCounter = false,
    this.hintText = '',
    this.extraInfo,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.showErrors = true,
    this.reverseFocusColor = false,
    this.floatingLabelBehavior,
    this.onSubmitted,
    this.textInputAction,
    this.obscureText = false,
    super.key,
  });

  final Map<String, String Function(Object messages)>? validationMessages;
  final bool autofocus;
  final BorderRadius? borderRadius;
  final String? extraInfo;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FormControl formControl;
  final bool hasCounter;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String labelText;
  final int maxLines;
  final int? minLines;
  final VoidCallback? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool reverseFocusColor;
  final bool showErrors;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool obscureText;

  Map<String, String Function(Object messages)>? get _validationMessages => {
        ValidationMessage.minLength: (error) => $.tr.design.widgets.reactives.fabReactiveTextfield.minLength(
              field: labelText.capitalize(),
              count: (error as Map)['requiredLength'].toString(),
            ),
        ValidationMessage.maxLength: (error) => $.tr.design.widgets.reactives.fabReactiveTextfield.maxLength(
              field: labelText.capitalize(),
              count: (error as Map)['requiredLength'].toString(),
            ),
        ValidationMessage.required: (_) => $.tr.design.widgets.reactives.fabReactiveTextfield.required(
              field: labelText.capitalize(),
            ),
        ValidationMessage.email: (_) => $.tr.design.widgets.reactives.fabReactiveTextfield.email(
              field: labelText.capitalize(),
            ),
        if (validationMessages != null) ...validationMessages!,
      };

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, _, __) {
        //final isValid = formControl.valid;
        //final isRequired = formControl.validators.any((v) => v is RequiredValidator);
        //final minLength = formControl.validators.whereType<MinLengthValidator>().map((v) => v.minLength).firstOrNull;
        final maxLength = formControl.validators.whereType<MaxLengthValidator>().map((v) => v.maxLength).firstOrNull;

        return Column(
          children: [
            ReactiveCupertinoTextField(
              padding: const EdgeInsets.all(12),
              onSubmitted: onSubmitted,
              textInputAction: textInputAction,
              autofocus: autofocus,
              readOnly: readOnly,
              onTap: onTap,
              maxLength: maxLength,
              maxLines: maxLines,
              minLines: minLines,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              inputFormatters: inputFormatters,
              formControl: formControl,
              placeholder: labelText,
              validationMessages: _validationMessages,
              showErrors:
                  showErrors ? (control) => control.invalid && (control.touched || control.dirty) : (_) => false,
            ),
            if (extraInfo != null)
              Positioned(
                left: 0,
                bottom: 0,
                width: context.mqWidth,
                child: Row(
                  children: [
                    const Icon(Icons.info),
                    Expanded(
                      child: PaddingLeft.xs(
                        child: Text(
                          extraInfo!,
                          style: context.textTheme.titleMedium?.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
