// ignore_for_file: max_lines_for_file

import 'package:flutter/material.dart';

import 'navigator_context.dart';

final class OverlayContext {
  OverlayContext(this._navigator);

  final NavigatorContext _navigator;

  OverlayEntry? _overlayEntry;
  Map<String, OverlayEntry> _overlays = <String, OverlayEntry>{};

  /// Show the overlay widget keeped by this class (it's like a single instance)
  /// It can be used many times, without an `overlayId`
  Future<OverlayEntry> showOverlay({Widget Function(BuildContext context)? builder}) async {
    hideOverlay();
    final overlayState = Overlay.of(_navigator.context!);
    _overlayEntry = OverlayEntry(builder: builder!);
    overlayState.insert(_overlayEntry!);

    return _overlayEntry!;
  }

  /// Hide the overlay widget keeped by this class (it's like a single instance)
  /// It can be used many times, without an `overlayId`
  void hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  /// Add an widget to overlay stack
  Future<String> addOverlay({
    required String overlayId,
    required Widget Function(BuildContext context) builder,
    OverlayEntry? below,
    OverlayEntry? above,
  }) async {
    final overlayState = Overlay.of(_navigator.context!);
    final overlayEntry = OverlayEntry(builder: builder);
    overlayState.insert(overlayEntry, above: above, below: below);
    _overlays.putIfAbsent(overlayId, () => overlayEntry);

    return overlayId;
  }

  /// Remove a widget from overlay stack by widget id `overlayId`
  void removeOverlay(String overlayId) {
    if (_overlays.containsKey(overlayId)) {
      var item = _overlays[overlayId];
      _overlays.remove(overlayId);
      item?.remove();
      item = null;
    }
  }

  /// Remove all overlays previously added from stack
  void removeAllOverlays() {
    _overlays.keys.forEach(removeOverlay);
    _overlays = <String, OverlayEntry>{};
  }

  /// Get OverlayEntry by id, if overlay with this id exists,
  /// else it will return null
  OverlayEntry? getOverlayById(String id) {
    if (_overlays.containsKey(id)) {
      return _overlays[id];
    }

    return null;
  }

  void rearrange(
    Iterable<OverlayEntry> newEntries, {
    OverlayEntry? below,
    OverlayEntry? above,
  }) {
    Overlay.of(_navigator.context!).rearrange(newEntries, below: below, above: above);
  }
}
