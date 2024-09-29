import 'package:equatable/equatable.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {
  final List<FeedModel> currentPosts;
  final bool isFirstLoad;

  const FeedLoading(this.currentPosts, {this.isFirstLoad = false});

  @override
  List<Object?> get props => [currentPosts, isFirstLoad];
}

class FeedLoaded extends FeedState {
  final List<FeedModel> posts;
  final bool hasReachedMax;

  const FeedLoaded(this.posts, {this.hasReachedMax = false});

  @override
  List<Object?> get props => [posts, hasReachedMax];
}

class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

class PostLiked extends FeedState {
  final FeedModel post;

  const PostLiked(this.post);

  @override
  List<Object?> get props => [post];
}

class CommentAdded extends FeedState {
  final FeedModel post;

  const CommentAdded(this.post);

  @override
  List<Object?> get props => [post];
}

class LikeAnimationState extends FeedState {
  final double scale;

  const LikeAnimationState({required this.scale});

  LikeAnimationState copyWith({bool? isLiked, double? scale}) {
    return LikeAnimationState(
      scale: scale ?? this.scale,
    );
  }
}