import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_feed/core/constants/string_constants.dart';
import 'package:social_media_feed/features/feed/presentation/cubit/feed/feed_cubit.dart';
import 'package:social_media_feed/features/feed/presentation/cubit/feed/feed_state.dart';
import 'package:social_media_feed/features/feed/presentation/widgets/comment_tile.dart';
import '../../data/models/feed_model.dart';
import '../pages/comments_page.dart';

class FeedCard extends StatefulWidget {
  final FeedModel post;
  final VoidCallback onLikePressed;
  final void Function(String comment) onCommentSubmitted;
  final TextEditingController? addCommentController;

  const FeedCard({
    super.key,
    required this.post,
    required this.onLikePressed,
    required this.onCommentSubmitted,
    required this.addCommentController,
  });

  @override
  FeedCardState createState() => FeedCardState();
}

class FeedCardState extends State<FeedCard>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
  }

  void _handleLike() {
    widget.onLikePressed();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _userImage(),
                const SizedBox(width: 10),
                _postDetails(),
              ],
            ),
            const SizedBox(height: 10),
            _feedImage(context),
            const SizedBox(height: 10),
            _postTitle(),
            const SizedBox(height: 5),
            Text(widget.post.body),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _likeButton(),
                if (widget.post.likesCount != null &&
                    widget.post.likesCount != 0)
                  _likesCount(),
                const SizedBox(width: 10),
                _addCommentView(),
              ],
            ),
            const SizedBox(height: 10),
            if (widget.post.comments?.isNotEmpty == true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _commentView(),
                  _moreCommentsView(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _userImage() => widget.post.userImage != null
      ? CircleAvatar(backgroundImage: NetworkImage(widget.post.userImage!))
      : const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        );

  Widget _postDetails() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userName(),
            const SizedBox(height: 2),
            _postedTimeAgo(),
          ],
        ),
      );

  Widget _userName() => Text(
        widget.post.userName ?? StringConstants.unknown,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );

  Widget _postedTimeAgo() => Text(
        widget.post.postedDate != null
            ? timeago.format(widget.post.postedDate!)
            : "",
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      );

  Widget _postTitle() => Text(
        widget.post.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _feedImage(BuildContext context) => widget.post.feedImage != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.post.feedImage!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            errorBuilder: (ctx, _, s) => const SizedBox(),
          ),
        )
      : const SizedBox();

  Widget _likeButton() => BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          scale = 1.0;
          if (state is LikeAnimationState) {
            scale = state.scale;
          }
          return GestureDetector(
            onTap: () => _handleLike(),
            child: AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 200),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.post.isLike == true
                      ? Icons.thumb_up
                      : Icons.thumb_up_off_alt,
                  key: ValueKey<bool>(widget.post.isLike ?? false),
                  color:
                      widget.post.isLike == true ? Colors.blue : Colors.black,
                ),
              ),
            ),
          );
        },
      );

  Widget _likesCount() => Text(
        ' ${widget.post.likesCount ?? 0}',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
        ),
      );

  Widget _addCommentView() => Expanded(
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(child: _addCommentTextField()),
            ],
          ),
        ),
      );

  Widget _addCommentTextField() => TextFormField(
        controller: widget.addCommentController,
        decoration: InputDecoration(
          hintText: StringConstants.addCommentHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: onCommentSubmit,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 22,
          ),
        ),
        onFieldSubmitted: (String value) {
          onCommentSubmit();
        },
      );

  Widget _commentView() => CommentTile(
        userImage: widget.post.userImage,
        comment: widget.post.comments!.last,
        fromFeed: true,
        onPressed: () {
          _onNavComments();
        },
      );

  Widget _moreCommentsView() => widget.post.comments!.length - 1 > 0
      ? GestureDetector(
          onTap: () {
            _onNavComments();
          },
          child: Text(
            "view ${widget.post.comments!.length - 1} more comments",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        )
      : const SizedBox.shrink();

  //! Functions
  void onCommentSubmit() {
    final comment = widget.addCommentController?.text.trim();
    if (comment != null && comment.isNotEmpty) {
      widget.onCommentSubmitted(comment);
    }
  }

  void _onNavComments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsPage(
          post: widget.post,
          onCommentSubmitted: widget.onCommentSubmitted,
        ),
      ),
    );
  }
}
