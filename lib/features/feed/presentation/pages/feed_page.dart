import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import '../../data/models/feed_model.dart';
import '../cubit/feed/feed_cubit.dart';
import '../cubit/feed/feed_state.dart';
import '../widgets/feed_card.dart';
import '../widgets/loading_indicator.dart';
import 'comments_page.dart';
import 'create_post_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  late FeedCubit _feedCubit;
  final ScrollController _scrollController = ScrollController();

  final Map<int, TextEditingController> _commentControllers = {};
  bool _isNavigatingToComments = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _commentControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _feedCubit = context.read<FeedCubit>();
    _scrollController.addListener(_onScroll);
    _feedCubit.loadPosts();
  }

  void _onScroll() {
    if (_isBottom) _feedCubit.loadPosts();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {
          if (state is CommentAdded && !_isNavigatingToComments) {
            _isNavigatingToComments = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CommentsPage(
                  post: state.post,
                  onCommentSubmitted: (String comment) {
                    _feedCubit.commentOnPost(state.post, comment);
                  },
                ),
              ),
            ).then((_) => _isNavigatingToComments = false);
          }
        },
        builder: _builder,
      ),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(
        title: const Text(StringConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreatePostPage()),
              );
            },
          ),
        ],
      );

  Widget _builder(BuildContext context, FeedState state) {
    if (state is FeedInitial || (state is FeedLoading && state.isFirstLoad)) {
      return const LoadingIndicator();
    } else if (state is FeedLoaded || state is FeedLoading) {
      List<FeedModel> posts = (state is FeedLoaded)
          ? state.posts
          : (state as FeedLoading).currentPosts;

      return RefreshIndicator(
        onRefresh: () async => _feedCubit.refresh(),
        child: _postsListView(
          posts,
          state is FeedLoading,
        ),
      );
    } else if (state is FeedError) {
      return _postsErrorBuilder(state);
    }
    return const SizedBox.shrink();
  }

  Widget _postsListView(List<FeedModel> posts, bool isLoading) =>
      ListView.builder(
        controller: _scrollController,
        itemCount: posts.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < posts.length) {
            var post = posts[index];

            _commentControllers.putIfAbsent(
                post.id, () => TextEditingController());

            return _postCard(post);
          } else if (isLoading) {
            return const LoadingIndicator();
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget _postCard(FeedModel post) => FeedCard(
        post: post,
        addCommentController: _commentControllers[post.id],
        onLikePressed: () {
          _feedCubit.likePost(post);
        },
        onCommentSubmitted: (String comment) {
          _feedCubit.commentOnPost(post, comment);
          _commentControllers[post.id]?.clear();
        },
      );

  Widget _postsErrorBuilder(FeedError state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _feedCubit.refresh,
              child: const Text(StringConstants.retry),
            ),
          ],
        ),
      );
}
