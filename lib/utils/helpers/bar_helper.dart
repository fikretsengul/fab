import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_boilerplate/features/app/models/alert_model.dart';
import 'package:flutter_advanced_boilerplate/features/app/widgets/bar/bar.dart';
import 'package:flutter_advanced_boilerplate/utils/methods/shortcuts.dart';

@immutable
abstract class BarHelper {
  const BarHelper._();

  static void showAlert(
    BuildContext context, {
    required AlertModel alert,
  }) {
    final message = alert.translatable ? tr(alert.message) : alert.message;

    if (alert.type == AlertType.constructive) {
      _createAlertModal(
        message: message,
        iconWidget: const SizedBox(),
        backgroundGradient: colorsToGradient([Colors.green, Colors.green]),
      ).show(context);
    } else if (alert.type == AlertType.destructive) {
      _createAlertModal(
        message: message,
        iconWidget: const SizedBox(),
        backgroundGradient: colorsToGradient([Colors.red, Colors.red]),
      ).show(context);
    } else if (alert.type == AlertType.error) {
      _createAlertModal(
        message: message,
        iconWidget: const SizedBox(),
        backgroundGradient: colorsToGradient([Colors.red, Colors.red]),
      ).show(context);
    } else if (alert.type == AlertType.notification) {
      _createAlertModal(
        message: message,
        iconWidget: Container(
          height: 24,
          width: 24,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
          ),
          margin: const EdgeInsets.all(4),
        ),
      ).show(context);
    } else if (alert.type == AlertType.quiet) {
      return;
    } else {
      _createAlertModal(
        message: message,
        iconWidget: const SizedBox(),
        backgroundGradient: colorsToGradient([Colors.red, Colors.red]),
      ).show(context);
    }
  }

  static Bar<void> _createAlertModal({
    required String message,
    required Widget iconWidget,
    Gradient? backgroundGradient,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Bar<void>(
      title: title,
      message: message,
      barPosition: BarPosition.top,
      icon: Padding(
        padding: const EdgeInsets.all(8),
        child: iconWidget,
      ),
      maxHeight: 60,
      backgroundColor: Colors.grey,
      backgroundGradient: backgroundGradient,
      messageSize: 16,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      margin: const EdgeInsets.all(8),
      shouldIconPulse: false,
      duration: duration,
    );
  }
}
