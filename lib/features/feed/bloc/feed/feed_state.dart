part of 'feed_bloc.dart';

@immutable
abstract class FeedState extends Equatable {
  const FeedState();
}

class InitialFeedState extends FeedState {
  const InitialFeedState();

  @override
  List<dynamic> get props => const [];
}

class LoadingFeedState extends FeedState {
  const LoadingFeedState();

  @override
  List<dynamic> get props => const [];
}

class SuccessFeedState extends FeedState {
  final List<Post> posts;

  const SuccessFeedState({
    required this.posts,
  });

  @override
  List<dynamic> get props => [posts];
}
