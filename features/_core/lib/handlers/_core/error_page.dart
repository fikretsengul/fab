// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_core/super/contexts/toast_context.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.details, super.key});
  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100,
                  color: context.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'Oups! Something went wrong!',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Text(
                          details.exceptionAsString(),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: details.exceptionAsString()));
                              $.toast.showToast(message: 'Copied!', alignment: ToastAlignment.bottom);
                            },
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
