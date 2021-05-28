import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/post.dart';
import '../../../../repository/post_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository postRepository;

  FeedBloc({
    required this.postRepository,
  }) : super(const InitialFeedState());

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is FeedEventGet) {
      yield const LoadingFeedState();
      final posts = await Future.delayed(
        const Duration(seconds: 2),
        postRepository.getFriendsPosts,
      );
      yield SuccessFeedState(posts: posts);
    }
  }
}
