import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:microblogging/models/post.dart';
import 'package:microblogging/utils/class_utils.dart';

import '../../../../repository/post_repository.dart';

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

      yield SuccessPostState(
        posts: response.posts,
        pages: response.pages,
      );
    } else if (event is PostsEventGetNextPage && state is SuccessPostState) {
      yield (state as SuccessPostState).mergeWith(
        isLoadingNextPage: true,
      );

      final response = await Future.delayed(
        const Duration(seconds: 2),
        () => postRepository.getPosts(page: event.page),
      );

      yield (state as SuccessPostState).mergeWith(
        posts: response.posts,
        pages: response.pages,
        isLoadingNextPage: false,
      );
    }
  }
}
