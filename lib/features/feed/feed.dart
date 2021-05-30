import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/post.dart';
import '../../blocs/feed/feed_bloc.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
            print(state);
            if (state is LoadingFeedState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is SuccessFeedState) {
              return Column(
                children: state.posts
                    .map(
                      (post) => PostCard(post: post),
                    )
                    .toList(),
              );
            }
            if (state is InitialFeedState) {
              BlocProvider.of<FeedBloc>(context).add(const FeedEventGet());
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
