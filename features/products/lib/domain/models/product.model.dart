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
    @Default(0) int discountRate,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.empty() => ProductModel(
        id: 0,
        title: 'Lorem ipsum dolor',
        price: 100,
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ac ullamcorper ligula. Quisque leo est, pellentesque vel hendrerit sit amet, varius vitae tortor.',
        images: [],
        creationAt: '',
        updatedAt: '',
        category: CategoryModel.empty(),
      );

  ProductModel._();

  bool get isEmpty => this == ProductModel.empty();
  double get discountPrice => price * (1 - discountRate / 100.0);
}
