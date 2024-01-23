import 'package:deps/packages/freezed_annotation.dart';

import 'category.model.dart';

part 'product.model.freezed.dart';
part 'product.model.g.dart';

@freezed
sealed class ProductModel with _$ProductModel {
  factory ProductModel({
    required int id,
    required String title,
    required int price,
    required String description,
    required List<String> images,
    required String creationAt,
    required String updatedAt,
    required CategoryModel category,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.empty() => ProductModel(
        id: 0,
        title: '',
        price: 0,
        description: '',
        images: [],
        creationAt: '',
        updatedAt: '',
        category: CategoryModel.empty(),
      );

  ProductModel._();

  bool get isEmpty => this == ProductModel.empty();
}
