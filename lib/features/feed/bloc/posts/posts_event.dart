part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class PostsEventGet extends PostsEvent {
  const PostsEventGet();

  @override
  List<Object?> get props => const [];
}

class PostsEventGetNextPage extends PostsEvent {
  final int page;

  const PostsEventGetNextPage({required this.page});

  @override
  List<Object?> get props => [page];
}
