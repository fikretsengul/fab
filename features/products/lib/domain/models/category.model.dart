import 'package:deps/packages/freezed_annotation.dart';

part 'category.model.freezed.dart';
part 'category.model.g.dart';

@freezed
sealed class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    required int id,
    required String name,
    required String image,
    required String creationAt,
    required String updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  factory CategoryModel.empty() => CategoryModel(
        id: 0,
        name: '',
        image: '',
        creationAt: '',
        updatedAt: '',
      );

  factory CategoryModel.skeleton() => CategoryModel(
        id: 0,
        name: 'Lorem ipsum',
        image: '',
        creationAt: '',
        updatedAt: '',
      );

  CategoryModel._();

  bool get isEmpty => this == CategoryModel.empty();
}
