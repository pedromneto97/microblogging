import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../blocs/posts/posts_bloc.dart';
import '../../repository/post_repository.dart';
import 'post.dart';
import 'widgets/post_list_view.dart';

class MyPosts extends StatelessWidget {
  static const screenName = 'my_posts';

  const MyPosts();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc(
        postRepository: RepositoryProvider.of<PostRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas publicações'),
        ),
        body: Column(
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) => PostListView(
                userId: (state as AuthenticationSuccessState).user.id,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PostScreen(),
                settings: const RouteSettings(name: PostScreen.screenName),
              ),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
