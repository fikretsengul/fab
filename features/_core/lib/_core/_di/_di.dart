// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';
import 'package:feature_auth/_core/_di/_di.dart';
import 'package:feature_user/_di/_di.dart';

import '_di.config.dart';

@InjectableInit(initializerName: 'init')
void injectAllFeatures(GetIt di, String env) {
  di.init(environment: env);

  injectAuthFeature(di, env);
  injectUserFeature(di, env);
}
