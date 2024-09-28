import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/feed/feed_cubit.dart';
import '../cubit/feed/feed_state.dart';
import '../widgets/feed_card.dart';
import 'comments_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  // Generate a list of random avatar URLs
  List<String> generateRandomAvatarUrls(int count) {
    return List<String>.generate(count, (index) {
      final randomNumber = Random().nextInt(100);
      return 'https://i.pravatar.cc/300?u=$randomNumber';
    });
  }

  // Generate a list of random feed image URLs
  List<String> generateRandomFeedUrls(int count) {
    return List<String>.generate(count, (index) {
      final randomNumber = Random().nextInt(100);
      return 'https://picsum.photos/500/300?random=$randomNumber';
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FeedCubit>().loadPosts(currentPage); // Load initial posts
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<FeedCubit>().loadPosts(++currentPage); // Load next page when scrolling to the end
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Feed')),
      body: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {
          if (state is PostLiked) {
          } else if (state is CommentAdded) {
          }
        },
        builder: (context, state) {
          if (state is FeedLoading && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            final avatarUrls = generateRandomAvatarUrls(state.posts.length);
            final feedUrls = generateRandomFeedUrls(state.posts.length);

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length + 1,
              itemBuilder: (context, index) {
                if (index < state.posts.length) {
                  final post = state.posts[index].copyWith(
                    userImage: avatarUrls[index],
                    feedImage: feedUrls[index],
                  );
                  return FeedCard(
                    post: post,
                    onLikePressed: () {
                      context.read<FeedCubit>().likePost(post.id);
                    },
                    onCommentPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentsPage(postId: post.id),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state is FeedError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load posts.'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FeedCubit>().loadPosts(1);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No posts available.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
