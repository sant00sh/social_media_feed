import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import 'package:social_media_feed/core/utils/utilities.dart';
import 'package:social_media_feed/features/feed/data/models/user_model.dart';
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
  Future<Either<Failure, List<FeedModel>>> getPosts(int start) async {
    try {
      const limit = 10; // Fetch 10 posts at a time
      final List<FeedModel> cachedPosts = postsBox.values.toList();

      // Check if we have enough cached posts
      if (cachedPosts.length > start) {
        return Right(cachedPosts.skip(start).take(limit).toList());
      }

      // Fetch new posts from the network
      var newPosts = await remoteDataSource.getPosts(start, limit: limit);

      if (newPosts.isEmpty) {
        // No more posts to fetch
        return Right(cachedPosts.skip(start).toList());
      }

      // Generate avatar and feed URLs
      final avatarUrls = Utilities.generateRandomAvatarUrls(newPosts.length);
      final feedUrls = Utilities.generateRandomFeedUrls(newPosts.length);

      newPosts = await Future.wait(newPosts.asMap().entries.map((entry) async {
        final index = entry.key;
        final post = entry.value;
        UserModel userDetails;
        try {
          userDetails = await remoteDataSource.getUserDetails(post.id);
        } on Exception catch (e) {
          userDetails = await remoteDataSource.getUserDetails(1);
        }

        return post.copyWith(
          userName: userDetails.username,
          userEmail: userDetails.email,
          postedDate: DateTime.now(),
          userImage: avatarUrls[index],
          feedImage: feedUrls[index],
        );
      }));

      // Add the new posts to Hive
      await postsBox.addAll(newPosts);

      return Right(newPosts);
    } catch (e) {
      List<FeedModel> cachedPosts = postsBox.values.toList();
      if (cachedPosts.isNotEmpty) {
        return Right(cachedPosts);
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FeedModel>> createPost(
      String title, String body) async {
    try {
      // Generate avatar and feed URLs
      final avatarUrls = Utilities.generateRandomAvatarUrls(1);
      final feedUrls = Utilities.generateRandomFeedUrls(1);

      var newPost = await remoteDataSource.createPost({
        'title': title,
        'body': body,
        'userId': 1, // static user id
      });

      newPost = newPost.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        userImage: avatarUrls.first,
        feedImage: feedUrls.first,
        postedDate: DateTime.now(),
      );

      final List<FeedModel> allPosts = postsBox.values.toList();
      allPosts.insert(0, newPost);

      await postsBox.clear();
      await postsBox.addAll(allPosts);

      return Right(newPost);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likePost(FeedModel feedPost) async {
    try {
      var posts = postsBox.values.toList();
      var post = posts.firstWhere((p) => p.id == feedPost.id);
      int idx = posts.indexOf(post);
      final isLiked = post.isLike ?? false;
      final updatedPost = post.copyWith(
        isLike: !isLiked,
        likesCount:
            isLiked ? (post.likesCount ?? 1) - 1 : (post.likesCount ?? 0) + 1,
      );

      await postsBox.putAt(idx, updatedPost);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FeedModel>> commentOnPost(
      FeedModel feedPost, String comment) async {
    try {
      final postIndex =
          postsBox.values.toList().indexWhere((p) => p.id == feedPost.id);
      if (postIndex != -1) {
        final post = postsBox.getAt(postIndex);
        if (post != null) {
          final newComment = CommentModel(
            id: DateTime.now().millisecondsSinceEpoch,
            name: StringConstants.unknown,
            body: comment,
            postId: post.id,
          );

          final updatedComments = List<CommentModel>.from(post.comments ?? [])
            ..add(newComment);

          final updatedPost = post.copyWith(
            comments: updatedComments,
          );

          await postsBox.putAt(postIndex, updatedPost);
          return Right(updatedPost);
        }
      }
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
