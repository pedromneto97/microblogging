import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/posts/posts_bloc.dart';
import '../../../models/post.dart';
import '../../../widgets/alert_widget.dart';
import '../../../widgets/post.dart';

class PostListView extends StatelessWidget {
  final String? userId;
  final void Function(Post post)? onTap;

  const PostListView({
    Key? key,
    this.userId,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final state = BlocProvider.of<PostsBloc>(context).state;
        if (notification.metrics.extentAfter < 20 &&
            state is SuccessPostsState &&
            !state.isLoadingNextPage &&
            state.page < state.pages) {
          BlocProvider.of<PostsBloc>(context).add(
            PostsEventGetNextPage(
              page: state.page + 1,
              userId: userId,
            ),
          );
        }
        return true;
      },
      child: Expanded(
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is InitialPostsState) {
              BlocProvider.of<PostsBloc>(context).add(
                PostsEventGet(userId: userId),
              );
            }
            if (state is InProgressPostsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SuccessPostsState) {
              if (state.posts.isEmpty) {
                return const AlertWidget(
                  iconColor: Colors.orange,
                  text: 'Ops, parece que não há nenhuma publicação',
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (state.isLoadingNextPage && index == state.posts.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return PostCard(
                    post: state.posts[index],
                    onTap:
                        onTap != null ? () => onTap!(state.posts[index]) : null,
                  );
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
    );
  }
}
