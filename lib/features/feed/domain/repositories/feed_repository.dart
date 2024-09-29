import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/feed_model.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<FeedModel>>> getPosts(int page);
  Future<Either<Failure, void>> likePost(FeedModel post);
  Future<Either<Failure, FeedModel>> commentOnPost(FeedModel post, String comment);
  Future<Either<Failure, FeedModel>> createPost(String title, String body);
}
