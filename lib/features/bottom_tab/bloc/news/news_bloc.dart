import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/exceptions.dart';
import '../../../../models/post.dart';
import '../../../../repository/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({
    required this.newsRepository,
  }) : super(const InitialNewsState());

  final NewsRepository newsRepository;

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsEventGet) {
      try {
        yield const InProgressNewsState();
        final news = await newsRepository.getNews();
        yield SuccessNewsState(news: news);
      } on MyException catch (e) {
        yield FailureNewsState(exception: e);
      } on Exception catch (_) {
        yield const FailureNewsState();
      }
    }
  }
}
