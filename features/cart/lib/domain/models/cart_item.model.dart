import 'package:deps/features/features.dart';
import 'package:deps/packages/freezed_annotation.dart';

part 'cart_item.model.freezed.dart';

@freezed
sealed class CartItemModel with _$CartItemModel {
  factory CartItemModel({
    required int id,
    required ProductModel product,
    required int quantity,
  }) = _CartItemModel;

  factory CartItemModel.empty() => CartItemModel(
        id: 0,
        product: ProductModel.empty(),
        quantity: 0,
      );

/*   CartItemModel._();

  bool get isEmpty => this == CartItemModel.empty(); */
}
