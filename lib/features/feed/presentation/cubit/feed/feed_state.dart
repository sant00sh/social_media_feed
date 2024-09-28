import 'package:equatable/equatable.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<FeedModel> posts;

  const FeedLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostLiked extends FeedState {
  final int postId;

  const PostLiked(this.postId);

  @override
  List<Object?> get props => [postId];
}

class CommentAdded extends FeedState {
  final int postId;

  const CommentAdded(this.postId);

  @override
  List<Object?> get props => [postId];
}
