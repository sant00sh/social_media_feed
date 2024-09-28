import 'package:dartz/dartz.dart';
import 'package:social_media_feed/core/error/failures.dart';
import 'package:social_media_feed/core/usecases/usecase.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';
import 'package:social_media_feed/features/feed/domain/repositories/feed_repository.dart';

class GetPostsUseCase implements UseCase<List<FeedModel>, int> {
  final FeedRepository repository;

  GetPostsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FeedModel>>> call(int page) async {
    return await repository.getPosts(page);
  }
}
