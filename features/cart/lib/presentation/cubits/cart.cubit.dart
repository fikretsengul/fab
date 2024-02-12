// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/features/features.dart';
import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:deps/packages/hydrated_bloc.dart';
import 'package:deps/packages/injectable.dart';

import '../../domain/models/cart_item.model.dart';

part 'cart.cubit.freezed.dart';
part 'states/cart.state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit(this._client) : super(CartState.initial());

  final INetworkClient _client;

  void addToCart(ProductModel product) {
    emit(
      state.copyWith(
        cartItems: [
          ...state.cartItems,
          CartItemModel(
            id: product.id,
            product: product,
            quantity: 1,
          ),
        ],
      ),
    );
  }

  void increaseQuantity(int id) {
    final index = state.cartItems.indexWhere((element) => element.id == id);
    final cartItem = state.cartItems[index];
    final newCartItems = List<CartItemModel>.from(state.cartItems);

    final newCartItem = cartItem.copyWith(quantity: cartItem.quantity + 1);
    newCartItems[index] = newCartItem;

    emit(
      state.copyWith(
        cartItems: newCartItems,
      ),
    );
  }

  void decreaseQuantity(int id) {
    final index = state.cartItems.indexWhere((element) => element.id == id);
    final cartItem = state.cartItems[index];
    final newCartItems = List<CartItemModel>.from(state.cartItems);

    if (cartItem.quantity == 1) {
      newCartItems.removeAt(index);
    } else {
      final newCartItem = cartItem.copyWith(quantity: cartItem.quantity - 1);
      newCartItems[index] = newCartItem;
    }

    emit(
      state.copyWith(
        cartItems: newCartItems,
      ),
    );
  }
}
