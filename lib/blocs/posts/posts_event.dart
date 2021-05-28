part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class PostsEventGet extends PostsEvent {
  final String? userId;

  const PostsEventGet({
    this.userId,
  });

  @override
  List<String?> get props => [userId];
}

class PostsEventGetNextPage extends PostsEvent {
  final int page;
  final String? userId;

  const PostsEventGetNextPage({
    required this.page,
    this.userId,
  });

  @override
  List<Object?> get props => [page];
}
