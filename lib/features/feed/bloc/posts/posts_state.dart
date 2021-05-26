part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  const PostsState();
}

class InitialPostsState extends PostsState {
  const InitialPostsState();

  @override
  List<Object?> get props => const [];
}

class InProgressPostsState extends PostsState {
  const InProgressPostsState();

  @override
  List<Object?> get props => const [];
}

class SuccessPostState extends PostsState implements MergeWith {
  final List<Post> posts;
  final int page;
  final int pages;
  final bool isLoadingNextPage;

  SuccessPostState({
    required this.posts,
    required this.pages,
    this.page = 1,
    this.isLoadingNextPage = false,
  });

  @override
  SuccessPostState mergeWith({
    List<Post>? posts,
    int? pages,
    int? page,
    bool? isLoadingNextPage,
  }) =>
      SuccessPostState(
        posts: posts != null ? [...this.posts, ...posts] : this.posts,
        pages: pages ?? this.pages,
        page: page ?? this.page,
        isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      );

  @override
  List<Object?> get props => [posts, pages, page, isLoadingNextPage];
}
