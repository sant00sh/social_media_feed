import 'package:flutter/material.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import 'package:social_media_feed/features/feed/presentation/widgets/comment_tile.dart';
import '../../data/models/feed_model.dart';

class CommentsPage extends StatelessWidget {
  final FeedModel post;
  final void Function(String) onCommentSubmitted;

  CommentsPage({
    super.key,
    required this.post,
    required this.onCommentSubmitted,
  });

  final TextEditingController addCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.comments),
        centerTitle: true,
      ),
      body: post.comments != null && post.comments!.isNotEmpty
          ? Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: post.comments!.length,
                    itemBuilder: (context, index) {
                      final comment = post.comments!.reversed.toList()[index];
                      return CommentTile(
                        userImage: post.userImage,
                        comment: comment,
                      );
                    },
                  ),
                ),
                _addCommentTextField(context),
              ],
            )
          : const Center(child: Text(StringConstants.noComments)),
    );
  }

  Widget _addCommentTextField(BuildContext context) => Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: addCommentController,
          decoration: InputDecoration(
            hintText: StringConstants.addCommentHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: () {
                onCommentSubmit(context);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 22,
            ),
          ),
          onFieldSubmitted: (String value) {
            onCommentSubmit(context);
          },
        ),
      );

  //! Functions
  void onCommentSubmit(BuildContext context) {
    final comment = addCommentController.text.trim();
    if (comment.isNotEmpty) {
      addCommentController.clear();
      Navigator.pop(context);
      onCommentSubmitted(comment);
    }
  }
}
