import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_model.freezed.dart';
part 'paginated_model.g.dart';

@freezed
@JsonSerializable(genericArgumentFactories: true)
class PaginatedModel<T> with _$PaginatedModel<T> {
  const factory PaginatedModel({
    required int currentPage,
    required int size,
    required int total,
    required List<T> items,
  }) = _PaginatedModel;

  factory PaginatedModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$PaginatedModelFromJson<T>(json, fromJsonT);
  }

  factory PaginatedModel.initial() => PaginatedModel<T>(currentPage: 1, size: 100, total: 0, items: <T>[]);
}
