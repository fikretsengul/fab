// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: boolean_prefix

import 'package:flutter/material.dart';

/// A widget which is not in the layout and does nothing.
/// It is useful when you have to return a widget and can't return null.
/// Use this widget to represent a non-existent widget, especially in conditional rendering.
class Nil extends Widget {
  /// Creates a [Nil] widget.
  const Nil({super.key});

  @override
  Element createElement() => _NilElement(this);
}

class _NilElement extends Element {
  _NilElement(Nil super.widget);

  /// Mounts the element to the widget tree.
  /// Asserts that it is not used under a MultiChildRenderObjectElement to prevent improper use.
  @override
  void mount(Element? parent, dynamic newSlot) {
    assert(parent is! MultiChildRenderObjectElement, """
        You are using Nil under a MultiChildRenderObjectElement.
        This suggests a possibility that the Nil is not needed or is being used improperly.
        Make sure it can't be replaced with an inline conditional or
        omission of the target widget from a list.
        """);

    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {
    super.performRebuild();
  }
}
