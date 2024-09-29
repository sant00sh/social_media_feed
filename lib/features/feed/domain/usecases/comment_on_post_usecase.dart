import 'package:dartz/dartz.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/feed_repository.dart';

class CommentOnPostUseCase implements UseCase<void, CommentParams> {
  final FeedRepository repository;

  CommentOnPostUseCase(this.repository);

  @override
  Future<Either<Failure, FeedModel>> call(CommentParams params) async {
    return await repository.commentOnPost(params.post, params.comment);
  }
}

class CommentParams {
  final FeedModel post;
  final String comment;

  CommentParams(this.post, this.comment);
}
