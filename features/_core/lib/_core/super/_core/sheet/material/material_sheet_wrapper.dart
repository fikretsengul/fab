// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class MaterialSheetWrapper extends StatelessWidget {
  const MaterialSheetWrapper({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: builder(context),
    );
  }
}
