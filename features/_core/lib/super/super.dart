// ignore_for_file: file_names

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/locator/locator.dart';

import 'constants/paddings.dart';
import 'constants/platform.dart';
import 'constants/radiuses.dart';
import 'constants/timings.dart';
import 'context/bloc_context.dart';
import 'context/modal_context.dart';
import 'context/navigator_context.dart';
import 'context/overlay_context.dart';

final class $ {
  factory $() => _instance;

  $._internal() {
    _navigator = NavigatorContext();
    _modal = ModalContext(_navigator);
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
  late final ModalContext _modal;
  late final OverlayContext _overlay;
  late final BlocContext _bloc;

  late final Timings _timings;
  late final Radiuses _radiuses;
  late final Paddings _paddings;
  late final Platform _platform;
  late final Permissions _permissions;

  /// Context
  static NavigatorContext navigator = _instance._navigator;
  static ModalContext modal = _instance._modal;
  static OverlayContext overlay = _instance._overlay;
  static BlocContext bloc = _instance._bloc;

  /// Constants
  static Timings get timings => _instance._timings;
  static Radiuses get radiuses => _instance._radiuses;
  static Paddings get paddings => _instance._paddings;
  static Platform get platform => _instance._platform;
  static Permissions get permissions => _instance._permissions;

  /// Aliases
  static T get<T extends Object>() => locator<T>();
  static void debug(dynamic data, [String? message]) => locator<ILogger>().log(data, message);
}
