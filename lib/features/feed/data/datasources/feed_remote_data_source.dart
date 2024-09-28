import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/comment_model.dart';
import '../models/feed_model.dart';

part 'feed_remote_data_source.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class FeedRemoteDataSource {
  factory FeedRemoteDataSource(Dio dio, {String baseUrl}) =
      _FeedRemoteDataSource;

  // Fetch posts with pagination
  @GET("/posts")
  Future<List<FeedModel>> getPosts(
    @Query("_start") int start, {
    @Query("_limit") int limit = 10,
  });

  //
  @POST("/posts/{postId}/like")
  Future<void> likePost(@Path("postId") int postId);

  // Add a comment to a post
  @POST("/posts/{postId}/comments")
  Future<void> commentOnPost(
      @Path("postId") int postId, @Body() CommentModel comment);

  // Fetch comments for a post
  @GET("/posts/{postId}/comments")
  Future<List<CommentModel>> getComments(@Path("postId") int postId);
}
