// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

part of '../cart.cubit.dart';

enum CartStateStatus { initial, loading, failed, succeeded }

@freezed
sealed class CartState with _$CartState {
  const factory CartState({
    required CartStateStatus status,
    required List<CartItemModel> cartItems,
    required Failure failure,
  }) = _CartState;

  factory CartState.initial() => CartState(
        status: CartStateStatus.initial,
        cartItems: [],
        failure: Failure.empty(),
      );
}
