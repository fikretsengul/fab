// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: file_names

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';
import 'package:flutter/material.dart';

import '../../cubits/translation/translation_cubit.dart';
import 'constants/paddings.dart';
import 'constants/platform.dart';
import 'constants/radiuses.dart';
import 'constants/timings.dart';
import 'contexts/bloc_context.dart';
import 'contexts/dialog_context.dart';
import 'contexts/navigator_context.dart';
import 'contexts/overlay_context.dart';
import 'contexts/toast_context.dart';
import 'permissions/permissions.dart';

@immutable
final class $ {
  factory $() => _instance;

  $._internal() {
    _navigator = NavigatorContext();
    _dialog = DialogContext(_navigator);
    _toast = ToastContext(_navigator);
    _overlay = OverlayContext(_navigator);
    _bloc = BlocContext(_navigator);
    _timings = Timings();
    _radiuses = Radiuses();
    _paddings = Paddings();
    _platform = Platform();
    _permissions = Permissions();
  }

  static final $ _instance = $._internal();

  // Props
  late final NavigatorContext _navigator;
  late final DialogContext _dialog;
  late final ToastContext _toast;
  late final OverlayContext _overlay;
  late final BlocContext _bloc;

  late final Timings _timings;
  late final Radiuses _radiuses;
  late final Paddings _paddings;
  late final Platform _platform;
  late final Permissions _permissions;

  /// Context
  static NavigatorContext navigator = _instance._navigator;
  static DialogContext dialog = _instance._dialog;
  static ToastContext toast = _instance._toast;
  static OverlayContext overlay = _instance._overlay;
  static BlocContext bloc = _instance._bloc;

  /// Constants
  static Timings get timings => _instance._timings;
  static Radiuses get radiuses => _instance._radiuses;
  static Paddings get paddings => _instance._paddings;
  static Platform get platform => _instance._platform;
  static Permissions get permissions => _instance._permissions;

  /// Aliases
  static TranslationCubit get tr => locator<TranslationCubit>();
  static T get<T extends Object>() => locator<T>();
  static void debug(dynamic data, [String? message]) => locator<ILogger>().debug(data, message);
  static void afterBuildCallback(ValueChanged<Duration> callback) =>
      WidgetsBinding.instance.addPostFrameCallback(callback);
}
