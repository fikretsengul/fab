// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:auth/_di/_di.dart';
import 'package:deps/packages/get_it.dart';
import 'package:deps/packages/injectable.dart';

@InjectableInit(initializerName: 'init')
void injectAllFeatures(GetIt di, String env) {
  injectAuthFeature(di, env);
}
