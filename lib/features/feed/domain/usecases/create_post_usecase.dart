import 'package:dartz/dartz.dart';
import 'package:social_media_feed/core/error/failures.dart';
import 'package:social_media_feed/core/usecases/usecase.dart';
import 'package:social_media_feed/features/feed/data/models/feed_model.dart';
import 'package:social_media_feed/features/feed/domain/repositories/feed_repository.dart';

class CreatePostUseCase implements UseCase<FeedModel, CreatePostParams> {
  final FeedRepository repository;

  CreatePostUseCase(this.repository);

  @override
  Future<Either<Failure, FeedModel>> call(CreatePostParams params) async {
    return await repository.createPost(params.title, params.body);
  }
}

class CreatePostParams {
  final String title;
  final String body;

  CreatePostParams(this.title, this.body);
}