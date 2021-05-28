part of 'post_crud_bloc.dart';

@immutable
abstract class PostCrudEvent extends Equatable {
  const PostCrudEvent();
}

class PostCrudEventCreate extends PostCrudEvent {
  final String text;
  final String userId;

  const PostCrudEventCreate({
    required this.text,
    required this.userId,
  });

  @override
  List<String> get props => [text, userId];
}

class PostCrudEventEdit extends PostCrudEvent {
  final String id;
  final String text;

  const PostCrudEventEdit({
    required this.id,
    required this.text,
  });

  @override
  List<String> get props => [id, text];
}
