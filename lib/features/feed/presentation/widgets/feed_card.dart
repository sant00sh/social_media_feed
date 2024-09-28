import 'package:flutter/material.dart';

import '../../data/models/feed_model.dart';

class FeedCard extends StatelessWidget {
  final FeedModel post;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;

  const FeedCard({
    super.key,
    required this.post,
    required this.onLikePressed,
    required this.onCommentPressed,
  });

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
                _postTitle(),
              ],
            ),
            const SizedBox(height: 10),
            _feedImage(context),
            const SizedBox(height: 10),
            Text(post.body),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _likeButton(),
                _commentsButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _userImage() => post.userImage != null
      ? CircleAvatar(
          backgroundImage: NetworkImage(
          post.userImage!,
        ))
      : const SizedBox();

  Widget _postTitle() => Expanded(
        child: Text(
          post.title,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  Widget _feedImage(BuildContext context) => post.feedImage != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            post.feedImage!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            errorBuilder: (ctx, _, s) => const SizedBox(),
          ),
        )
      : const SizedBox();

  Widget _likeButton() => IconButton(
        icon: Icon(
          Icons.thumb_up,
          color: post.isLike == true ? Colors.blue : Colors.black,
        ),
        onPressed: onLikePressed,
      );

  Widget _commentsButton() => IconButton(
        icon: const Icon(Icons.comment),
        onPressed: onCommentPressed,
      );
}
