// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'material_modal_config.dart';

@RoutePage()
class MaterialModalWrapperRoute extends StatelessWidget {
  const MaterialModalWrapperRoute({
    required this.builder,
    this.modalConfig = const MaterialModalConfig(),
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final MaterialModalConfig modalConfig;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: builder(context),
    );
  }
}
