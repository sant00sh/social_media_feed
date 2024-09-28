import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/feed_repository.dart';
import '../models/comment_model.dart';
import '../models/feed_model.dart';
import 'feed_remote_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final Box<FeedModel> postsBox;
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl(this.remoteDataSource, this.postsBox);

  @override
  Future<Either<Failure, List<FeedModel>>> getPosts(int page) async {
    try {
      if (postsBox.isNotEmpty) {
        // Load from Hive DB
        final posts = postsBox.values.toList();
        return Right(posts);
      } else {
        final posts = await remoteDataSource.getPosts(page);
        return Right(posts
            .map((post) => FeedModel(
                  id: post.id,
                  userId: post.userId,
                  title: post.title,
                  body: post.body,
                ))
            .toList());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likePost(int postId) async {
    try {
      // Retrieve the post from Hive
      final post = postsBox.get(postId - 1);
      if (post != null) {
        final isLiked = post.isLike ?? false;
        final updatedPost = post.copyWith(isLike: !isLiked);

        // Save the updated post back to Hive
        postsBox.put(postId, updatedPost);
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> commentOnPost(
      int postId, String comment) async {
    try {
      // Retrieve the post from Hive
      final post = postsBox.get(postId);
      if (post != null) {
        final newComment = CommentModel(
          id: DateTime.now().millisecondsSinceEpoch,
          name: "Anonymous",
          body: comment,
          postId: postId,
        );

        final updatedComments = List<CommentModel>.from(post.comments ?? [])
          ..add(newComment);

        final updatedPost = post.copyWith(comments: updatedComments);

        // Save the updated post back to Hive
        postsBox.put(postId, updatedPost);

        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
