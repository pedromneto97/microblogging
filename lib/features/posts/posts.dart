import 'package:flutter/material.dart';

import 'widgets/post_list_view.dart';

class Posts extends StatelessWidget {
  const Posts();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PostListView(),
      ],
    );
  }
}
