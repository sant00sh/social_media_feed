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
    @HiveField(4) String? userName,
    @HiveField(5) String? userEmail,
    @HiveField(6) String? userImage,
    @HiveField(7) String? feedImage,
    @HiveField(8) bool? isLike,
    @HiveField(9) List<CommentModel>? comments,
    @HiveField(10) int? likesCount,
    @HiveField(11) DateTime? postedDate,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) => _$FeedModelFromJson(json);
}
