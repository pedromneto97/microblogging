part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsEventGet extends NewsEvent {
  const NewsEventGet();

  @override
  List<Object?> get props => const [];
}
