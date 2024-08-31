// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';

class ATrackingScrollController extends ScrollController {
  /// Creates a scroll controller that continually updates its
  /// [initialScrollOffset] to match the last scroll notification it received.
  ATrackingScrollController({
    required this.until,
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
  });

  final double until;
  final Map<ScrollPosition, VoidCallback> _positionToListener = <ScrollPosition, VoidCallback>{};
  ScrollPosition? _lastUpdated;
  double? _lastUpdatedOffset;

  /// The last [ScrollPosition] to change. Returns null if there aren't any
  /// attached scroll positions, or there hasn't been any scrolling yet, or the
  /// last [ScrollPosition] to change has since been removed.
  ScrollPosition? get mostRecentlyUpdatedPosition => _lastUpdated;

  /// Returns the scroll offset of the [mostRecentlyUpdatedPosition] or, if that
  /// is null, the initial scroll offset provided to the constructor.
  ///
  /// See also:
  ///
  ///  * [ScrollController.initialScrollOffset], which this overrides.
  @override
  double get initialScrollOffset => _lastUpdatedOffset ?? super.initialScrollOffset;

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    assert(!_positionToListener.containsKey(position));
    _positionToListener[position] = () {
      _lastUpdated = position;
      _lastUpdatedOffset = position.pixels > until ? until : position.pixels;
    };
    position.addListener(_positionToListener[position]!);
  }

  @override
  void detach(ScrollPosition position) {
    super.detach(position);
    assert(_positionToListener.containsKey(position));
    position.removeListener(_positionToListener[position]!);
    _positionToListener.remove(position);
    if (_lastUpdated == position) {
      _lastUpdated = null;
    }
    if (_positionToListener.isEmpty) {
      _lastUpdatedOffset = null;
    }
  }

  @override
  void dispose() {
    for (final ScrollPosition position in positions) {
      assert(_positionToListener.containsKey(position));
      position.removeListener(_positionToListener[position]!);
    }
    super.dispose();
  }
}
