import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/post.dart';
import '../bloc/posts/posts_bloc.dart';

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
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final state = BlocProvider.of<PostsBloc>(context).state;
              if (notification.metrics.extentAfter < 20 &&
                  state is SuccessPostsState &&
                  !state.isLoadingNextPage &&
                  state.page < state.pages) {
                BlocProvider.of<PostsBloc>(context).add(
                  PostsEventGetNextPage(page: state.page + 1),
                );
              }
              return true;
            },
            child: Expanded(
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state is InitialPostsState) {
                    BlocProvider.of<PostsBloc>(context)
                        .add(const PostsEventGet());
                  }
                  if (state is InProgressPostsState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SuccessPostsState) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (state.isLoadingNextPage &&
                            index == state.posts.length) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return PostCard(post: state.posts[index]);
                      },
                      itemCount: state.isLoadingNextPage
                          ? state.posts.length + 1
                          : state.posts.length,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}