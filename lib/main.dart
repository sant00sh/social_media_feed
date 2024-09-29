import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import 'package:social_media_feed/features/feed/data/models/comment_model.dart';
import 'injection_container.dart' as di;
import 'features/feed/presentation/cubit/feed/feed_cubit.dart';
import 'features/feed/presentation/pages/feed_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/feed/data/models/feed_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the generated adapters
  Hive.registerAdapter(FeedModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());

  await di.init();

  runApp(const MySocialApp());
}

class MySocialApp extends StatelessWidget {
  const MySocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<FeedCubit>(),
        ),
      ],
      child: MaterialApp(
        title: StringConstants.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light, // Light theme
        ),
        darkTheme: ThemeData.dark(), // Dark theme
        themeMode: ThemeMode.system,
        home: const FeedPage(),
      ),
    );
  }
}
