part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class FeedEventGet extends FeedEvent {
  const FeedEventGet();

  @override
  List<dynamic> get props => const [];
}
