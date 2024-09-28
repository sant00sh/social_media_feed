import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/feed_repository.dart';

class LikePostUseCase implements UseCase<void, int> {
  final FeedRepository repository;

  LikePostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int postId) async {
    return await repository.likePost(postId);
  }
}
