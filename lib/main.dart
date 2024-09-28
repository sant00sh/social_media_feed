import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/feed/presentation/cubit/feed/feed_cubit.dart';
import 'features/feed/presentation/pages/feed_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/feed/data/models/feed_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the generated adapter
  Hive.registerAdapter(FeedModelAdapter());

  await di.init();

  runApp(const MySocialApp());
}

class MySocialApp extends StatelessWidget {
  const MySocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => di.sl<FeedCubit>(),
        child: const FeedPage(),
      ),
    );
  }
}
