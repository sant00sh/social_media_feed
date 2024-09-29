import 'package:dartz/dartz.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/feed_repository.dart';

class LikePostUseCase implements UseCase<void, FeedModel> {
  final FeedRepository repository;

  LikePostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(FeedModel post) async {
    return await repository.likePost(post);
  }
}
