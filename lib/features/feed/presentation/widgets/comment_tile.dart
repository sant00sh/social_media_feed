import 'package:flutter/material.dart';
import 'package:social_media_feed/features/feed/data/models/comment_model.dart';

class CommentTile extends StatelessWidget {
  final String? userImage;
  final CommentModel comment;
  final bool fromFeed;
  final VoidCallback? onPressed;

  const CommentTile({
    super.key,
    this.userImage,
    required this.comment,
    this.fromFeed = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        contentPadding: fromFeed ? EdgeInsets.zero : null,
        horizontalTitleGap: fromFeed ? 8 : null,
        dense: true,
        leading: _userImage(),
        title: Text(
          comment.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fromFeed ? 12 : null,
          ),
        ),
        subtitle: Text(
          comment.body,
          style: TextStyle(
            fontSize: fromFeed ? 12 : null,
          ),
        ),
      ),
    );
  }

  Widget _userImage() => userImage != null
      ? CircleAvatar(
          backgroundImage: NetworkImage(userImage!),
          radius: fromFeed ? 18 : null,
        )
      : _placeholderImage();

  Widget _placeholderImage() =>
      const CircleAvatar(backgroundColor: Colors.white70);
}
