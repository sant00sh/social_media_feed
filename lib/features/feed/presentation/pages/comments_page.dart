import 'package:flutter/material.dart';

class CommentsPage extends StatelessWidget {
  final int postId;

  const CommentsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('User $index'),
            subtitle: const Text('This is a comment'),
          );
        },
      ),
    );
  }
}
