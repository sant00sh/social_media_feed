import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/feed_repository.dart';

class CommentOnPostUseCase implements UseCase<void, CommentParams> {
  final FeedRepository repository;

  CommentOnPostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CommentParams params) async {
    return await repository.commentOnPost(params.postId, params.comment);
  }
}

class CommentParams {
  final int postId;
  final String comment;

  CommentParams(this.postId, this.comment);
}
