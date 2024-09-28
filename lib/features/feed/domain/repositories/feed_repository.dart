import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/feed_model.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<FeedModel>>> getPosts(int page);
  Future<Either<Failure, void>> likePost(int postId);
  Future<Either<Failure, void>> commentOnPost(int postId, String comment);
}
