import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'feed_state.dart';
import '../../../domain/usecases/get_posts_usecase.dart';
import '../../../domain/usecases/like_post_usecase.dart';
import '../../../domain/usecases/comment_on_post_usecase.dart';
import '../../../data/models/feed_model.dart';

class FeedCubit extends Cubit<FeedState> {
  final GetPostsUseCase getPostsUseCase;
  final LikePostUseCase likePostUseCase;
  final CommentOnPostUseCase commentOnPostUseCase;
  final Box<FeedModel> postsBox = Hive.box('postsBox');

  List<FeedModel> currentPosts = [];

  FeedCubit(
      this.getPostsUseCase, this.likePostUseCase, this.commentOnPostUseCase)
      : super(FeedInitial());

  Future<void> loadPosts(int page) async {
    emit(FeedLoading());

    int start = (page - 1) * 10;

    final failureOrPosts = await getPostsUseCase(start);
    failureOrPosts.fold(
      (failure) => emit(const FeedError("Failed to load posts")),
      (newPosts) {
        currentPosts.addAll(newPosts);
        emit(FeedLoaded(currentPosts));
      },
    );
  }

  Future<void> likePost(int postId) async {
    final failureOrSuccess = await likePostUseCase(postId);
    failureOrSuccess.fold(
      (failure) => emit(const FeedError("Failed to like the post")),
      (_) {
        final updatedPosts = postsBox.values.cast<FeedModel>().toList();
        emit(PostLiked(postId));
        emit(FeedLoaded(updatedPosts));
      },
    );
  }

  Future<void> commentOnPost(int postId, String comment) async {
    final failureOrSuccess =
        await commentOnPostUseCase(CommentParams(postId, comment));
    failureOrSuccess.fold(
      (failure) => emit(const FeedError("Failed to add comment")),
      (_) {
        final updatedPosts = postsBox.values.cast<FeedModel>().toList();
        emit(CommentAdded(postId));
        emit(FeedLoaded(updatedPosts));
      },
    );
  }
}
