// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: max_lines_for_file

import 'package:deps/features/features.dart';
import 'package:deps/packages/talker_bloc_logger.dart';
import 'package:deps/packages/talker_dio_logger.dart';

void main() async {
  await MainHandler.init(
    observerSettings: ObserverSettings(
      blocObserverEnabled: false,
      routerObserverEnabled: false,
      dioObserverEnabled: false,
      dioSettings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
      ),
      blocSettings: const TalkerBlocLoggerSettings(
        printChanges: true,
        printCreations: true,
        printClosings: true,
      ),
    ),
  );
}
