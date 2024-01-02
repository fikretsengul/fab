// ignore_for_file: file_names

import 'package:deps/infrastructure/analytics.dart';
import 'package:deps/locator/locator.dart';

import 'constants/paddings.dart';
import 'constants/platform.dart';
import 'constants/radiuses.dart';
import 'constants/timings.dart';
import 'utilities/bloc_context.dart';
import 'utilities/modal_context.dart';
import 'utilities/navigator_context.dart';
import 'utilities/overlay_context.dart';

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

  /// Utilities
  static NavigatorContext navigator = _instance._navigator;
  static ModalContext modal = _instance._modal;
  static OverlayContext overlay = _instance._overlay;
  static BlocContext bloc = _instance._bloc;

  /// Constants
  static Timings get timings => _instance._timings;
  static Radiuses get radiuses => _instance._radiuses;
  static Paddings get paddings => _instance._paddings;
  static Platform get platform => _instance._platform;

  /// Aliases
  static T locator<T extends Object>() => di<T>();
  static void debug(dynamic data, [String? message]) => di<ILogger>().log(data, message);
}
