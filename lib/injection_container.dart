import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/feed/data/datasources/feed_remote_data_source.dart';
import 'features/feed/data/datasources/feed_repository_impl.dart';
import 'features/feed/domain/repositories/feed_repository.dart';
import 'features/feed/domain/usecases/comment_on_post_usecase.dart';
import 'features/feed/domain/usecases/get_posts_usecase.dart';
import 'features/feed/domain/usecases/like_post_usecase.dart';
import 'features/feed/presentation/cubit/feed/feed_cubit.dart';
import 'features/feed/data/models/feed_model.dart';

// Create an instance of GetIt
final sl = GetIt.instance;

Future<void> init() async {
  // Register Hive Box for FeedModel
  final postsBox = await Hive.openBox<FeedModel>('postsBox');
  sl.registerSingleton<Box<FeedModel>>(postsBox);

  // Cubit
  sl.registerFactory(() => FeedCubit(
    sl(), // GetPostsUseCase
    sl(), // LikePostUseCase
    sl(), // CommentOnPostUseCase
  ));

  // Use cases
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => LikePostUseCase(sl()));
  sl.registerLazySingleton(() => CommentOnPostUseCase(sl()));

  // Repository
  sl.registerLazySingleton<FeedRepository>(
        () => FeedRepositoryImpl(sl(), sl()),
  );

  // Data sources
  sl.registerLazySingleton<FeedRemoteDataSource>(
        () => FeedRemoteDataSource(sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio());
}
