import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:social_media_feed/features/feed/data/models/user_model.dart';

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

  @POST("/posts")
  Future<FeedModel> createPost(@Body() Map<String, dynamic> post);

  @GET("/users/{userId}")
  Future<UserModel> getUserDetails(@Path("userId") int userId);
}
