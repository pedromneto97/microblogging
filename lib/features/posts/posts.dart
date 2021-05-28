import 'package:flutter/material.dart';

import 'widgets/post_list_view.dart';

class Posts extends StatelessWidget {
  const Posts();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              'Publicações'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const PostListView(),
        ],
      ),
    );
  }
}
