import 'package:flutter/material.dart';

import '../../../repository/post_repository.dart';
import '../../../widgets/post.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              'O que seus amigos andam fazendo'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          ...PostRepository()
              .getFriendsPosts()
              .map(
                (e) => PostCard(post: e),
              )
              .toList()
        ],
      ),
    );
  }
}
