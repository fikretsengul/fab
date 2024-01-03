// ignore_for_file: max_lines_for_file

import 'package:deps/packages/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'navigator_context.dart';

@immutable
final class BlocContext {
  BlocContext(this._navigator);

  final NavigatorContext _navigator;

  T read<T>() {
    return _navigator.context!.read<T>();
  }

  T watch<T>() {
    return _navigator.context!.watch<T>();
  }
}
