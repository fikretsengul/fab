// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/auto_route.dart';
import 'package:flutter/material.dart';

import 'cupertino_sheet_config.dart';

@RoutePage()
class CupertinoSheetWrapperRoute extends StatelessWidget {
  const CupertinoSheetWrapperRoute({
    required this.builder,
    this.dialogConfig = const CupertinoSheetConfig(),
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final CupertinoSheetConfig dialogConfig;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
