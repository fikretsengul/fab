// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/freezed_annotation.dart';

part 'paginated_list.state.freezed.dart';

@freezed
class PaginatedListState<T> with _$PaginatedListState<T> {
  const factory PaginatedListState.failed(IFailure failure) = PaginatedListFailed;

  const factory PaginatedListState.initial() = PaginatedListInitial;

  const factory PaginatedListState.loaded(List<T> items) = PaginatedListLoaded;

  const factory PaginatedListState.loading() = PaginatedListLoading;

  const factory PaginatedListState.refresh() = PaginatedListRefresh;
}
