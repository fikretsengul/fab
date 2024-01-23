// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/freezed_annotation.dart';

part 'paginated_list.state.freezed.dart';

@freezed
class PaginatedListState<T> with _$PaginatedListState<T> {
  const factory PaginatedListState.failed(IFailure failure) = PaginatedListStateFailed;

  const factory PaginatedListState.initial() = PaginatedListStateInitial;

  const factory PaginatedListState.loaded(List<T> items) = PaginatedListStateLoaded;

  const factory PaginatedListState.loading() = PaginatedListStateLoading;

  const factory PaginatedListState.refresh() = PaginatedListStateRefresh;
}
