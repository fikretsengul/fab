// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'cupertino_modal_config.dart';

@RoutePage()
class CupertinoModalWrapperRoute extends StatelessWidget {
  const CupertinoModalWrapperRoute({
    required this.builder,
    this.modalConfig = const CupertinoModalConfig(),
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final CupertinoModalConfig modalConfig;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
