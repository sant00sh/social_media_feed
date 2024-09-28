import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_feed/features/feed/data/models/comment_model.dart';

part 'feed_model.freezed.dart';
part 'feed_model.g.dart';

@HiveType(typeId: 0)
@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    @HiveField(0) required int id,
    @HiveField(1) required String title,
    @HiveField(2) required String body,
    @HiveField(3) required int userId,
    @HiveField(4) String? userImage,
    @HiveField(5) String? feedImage,
    @HiveField(6) bool? isLike,
    @HiveField(7) List<CommentModel>? comments,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) => _$FeedModelFromJson(json);
}
