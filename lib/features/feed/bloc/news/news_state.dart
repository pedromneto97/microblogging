part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable {
  const NewsState();
}

class InitialNewsState extends NewsState {
  const InitialNewsState();

  @override
  List<dynamic> get props => const [];
}

class InProgressNewsState extends NewsState {
  const InProgressNewsState();

  @override
  List<dynamic> get props => const [];
}

class SuccessNewsState extends NewsState {
  final List<Post> news;

  const SuccessNewsState({
    required this.news,
  });

  @override
  List<dynamic> get props => [news];
}

class FailureNewsState extends NewsState {
  final Exception? exception;

  const FailureNewsState({
    this.exception,
  });

  @override
  List<Exception?> get props => [exception];
}
