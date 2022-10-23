import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_rest_model.freezed.dart';
part 'post_rest_model.g.dart';

@freezed
class PostRestModel with _$PostRestModel {
  const factory PostRestModel({
    required String id,
    required String title,
  }) = _PostRestModel;

  factory PostRestModel.initial() => const PostRestModel(
        id: '',
        title: '',
      );

  factory PostRestModel.fromJson(Map<String, dynamic> json) => _$PostRestModelFromJson(json);
}
