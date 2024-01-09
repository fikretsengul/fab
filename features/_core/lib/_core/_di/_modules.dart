// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '_di.dart';

@module
abstract class FeaturesRouterModule {
  @lazySingleton
  FeaturesRouter get router => FeaturesRouter();
}
