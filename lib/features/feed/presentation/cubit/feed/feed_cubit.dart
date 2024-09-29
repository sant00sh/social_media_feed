import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import '../../../domain/usecases/create_post_usecase.dart';
import 'feed_state.dart';
import '../../../domain/usecases/get_posts_usecase.dart';
import '../../../domain/usecases/like_post_usecase.dart';
import '../../../domain/usecases/comment_on_post_usecase.dart';
import '../../../data/models/feed_model.dart';

class FeedCubit extends Cubit<FeedState> {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final LikePostUseCase likePostUseCase;
  final CommentOnPostUseCase commentOnPostUseCase;
  final Box<FeedModel> postsBox = Hive.box(StringConstants.postsBox);

  List<FeedModel> currentPosts = [];
  int currentPage = 1;
  static const int postsPerPage = 10;

  FeedCubit(
    this.getPostsUseCase,
    this.createPostUseCase,
    this.likePostUseCase,
    this.commentOnPostUseCase,
  ) : super(FeedInitial());

  Future<void> loadPosts({bool refresh = false}) async {
    if (state is FeedLoading) return;

    final currentState = state;
    List<FeedModel> oldPosts = [];
    if (currentState is FeedLoaded && !refresh) {
      oldPosts = currentState.posts;
    }

    emit(FeedLoading(oldPosts, isFirstLoad: currentPage == 1));

    final failureOrPosts =
        await getPostsUseCase((currentPage - 1) * postsPerPage);

    failureOrPosts.fold(
      (failure) => emit(const FeedError(StringConstants.loadPostsErr)),
      (newPosts) {
        currentPage++;
        final allPosts = refresh ? newPosts : [...oldPosts, ...newPosts];
        emit(FeedLoaded(allPosts, hasReachedMax: newPosts.isEmpty));
      },
    );
  }

  Future<void> createPost(String title, String body) async {
    if (state is FeedLoaded) {
      currentPosts = (state as FeedLoaded).posts;
    }
    emit(FeedLoading(currentPosts));

    final failureOrPost =
        await createPostUseCase(CreatePostParams(title, body));

    failureOrPost.fold(
      (failure) => emit(const FeedError(StringConstants.createPostErr)),
      (newPost) {
        currentPosts.insert(0, newPost);
        emit(FeedLoaded(currentPosts));
      },
    );
  }

  Future<void> likePost(FeedModel post) async {
    if (state is FeedLoaded) {
      currentPosts = (state as FeedLoaded).posts;
    }
    final failureOrSuccess = await likePostUseCase(post);
    failureOrSuccess.fold(
          (failure) => emit(const FeedError(StringConstants.likePostErr)),
          (_) {
        final updatedPosts = currentPosts.map((p) {
          if (p.id == post.id) {
            final isLiked = !(p.isLike ?? false);
            return p.copyWith(
              isLike: isLiked,
              likesCount: isLiked ? (p.likesCount ?? 0) + 1 : (p.likesCount ?? 1) - 1,
            );
          }
          return p;
        }).toList();
        currentPosts = updatedPosts;
        emit(PostLiked(post));
        emit(FeedLoaded(updatedPosts));
      },
    );
  }

  // Toggle the like state and trigger the animation
  void toggleLike(FeedModel post) {
    emit(const LikeAnimationState(scale: 1.5));

    Future.delayed(const Duration(milliseconds: 200), () {
      emit(const LikeAnimationState(scale: 1.0));
    });
  }

  Future<void> commentOnPost(FeedModel post, String comment) async {
    if (state is FeedLoaded) {
      currentPosts = (state as FeedLoaded).posts;
    }
    final failureOrSuccess =
        await commentOnPostUseCase(CommentParams(post, comment));
    failureOrSuccess.fold(
      (failure) => emit(const FeedError(StringConstants.commentOnPostErr)),
      (updatedPost) {
        final updatedPosts = currentPosts
            .map((p) => p.id == updatedPost.id ? updatedPost : p)
            .toList();
        currentPosts = updatedPosts;
        emit(CommentAdded(updatedPost));
        emit(FeedLoaded(updatedPosts));
      },
    );
  }

  void refresh() {
    currentPage = 1;
    currentPosts.clear();
    loadPosts(refresh: true);
  }
}
