// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'translations.g.dart';

mixin CoreTranslationMixin on Cubit<Locale> {
  Translations get core => AppLocaleUtils.parse(state.toString()).build();
}