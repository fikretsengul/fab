// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'translations.g.dart';

mixin CartTranslationMixin on Cubit<Locale> {
  Translations get user => AppLocaleUtils.parse(state.toString()).build();
}
