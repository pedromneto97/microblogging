import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../models/post.dart';
import '../../../../repository/post_repository.dart';
import '../../../../utils/class_utils.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({
    required this.postRepository,
  }) : super(const InitialPostsState());

  final PostRepository postRepository;

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is PostsEventGet) {
      yield const InProgressPostsState();

      final response = await Future.delayed(
        const Duration(seconds: 2),
        () => postRepository.getPosts(page: 1),
      );

      yield SuccessPostsState(
        posts: response.posts,
        pages: response.pages,
      );
    } else if (event is PostsEventGetNextPage && state is SuccessPostsState) {
      yield (state as SuccessPostsState).mergeWith(
        isLoadingNextPage: true,
      );

      final response = await Future.delayed(
        const Duration(seconds: 2),
        () => postRepository.getPosts(page: event.page),
      );

      yield (state as SuccessPostsState).mergeWith(
        posts: response.posts,
        page: event.page,
        pages: response.pages,
        isLoadingNextPage: false,
      );
    }
  }
}
