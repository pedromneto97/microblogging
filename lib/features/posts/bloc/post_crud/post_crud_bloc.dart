import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../repository/post_repository.dart';

part 'post_crud_event.dart';
part 'post_crud_state.dart';

class PostCrudBloc extends Bloc<PostCrudEvent, PostCrudState> {
  final PostRepository postRepository;

  PostCrudBloc({required this.postRepository})
      : super(const InitialPostCrudState());

  @override
  Stream<PostCrudState> mapEventToState(PostCrudEvent event) async* {
    if (event is PostCrudEventCreate) {
      yield const InProgressPostCrudState();

      await Future.delayed(
        const Duration(seconds: 2),
        () => postRepository.createPost(
          text: event.text,
          userId: event.userId,
        ),
      );

      yield const SuccessPostCrudState();
    } else if (event is PostCrudEventEdit) {
      yield const InProgressPostCrudState();

      await Future.delayed(
        const Duration(seconds: 2),
        () => postRepository.putPost(
          text: event.text,
          id: event.id,
        ),
      );

      yield const SuccessPostCrudState();
    }
  }
}
