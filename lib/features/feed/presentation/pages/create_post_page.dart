import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_feed/core/constants/string_constants.dart';
import '../cubit/feed/feed_cubit.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  CreatePostPageState createState() => CreatePostPageState();
}

class CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _onSubmitPost() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isNotEmpty && body.isNotEmpty) {
      context.read<FeedCubit>().createPost(title, body);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.createPost),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _titleTextField(),
            const SizedBox(height: 10),
            _contentTextField(),
            const SizedBox(height: 30),
            _submitPostButton(),
          ],
        ),
      ),
    );
  }

  Widget _titleTextField() => TextField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: StringConstants.postTitle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  Widget _contentTextField() => TextField(
        controller: _bodyController,
        decoration: InputDecoration(
          labelText: StringConstants.postContent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxLines: 3,
      );

  Widget _submitPostButton() => ElevatedButton(
        onPressed: _onSubmitPost,
        child: const Text(StringConstants.submitPost),
      );
}
