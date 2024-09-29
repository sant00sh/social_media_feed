import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
@HiveType(typeId: 1)
class CommentModel with _$CommentModel {
  const factory CommentModel({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required String body,
    @HiveField(3) required int postId,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
