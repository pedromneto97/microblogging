part of 'post_crud_bloc.dart';

@immutable
abstract class PostCrudState extends Equatable {
  const PostCrudState();
}

class InitialPostCrudState extends PostCrudState {
  const InitialPostCrudState();

  @override
  List<Object?> get props => const [];
}

class InProgressPostCrudState extends PostCrudState {
  const InProgressPostCrudState();

  @override
  List<Object?> get props => const [];
}

class SuccessPostCrudState extends PostCrudState {
  const SuccessPostCrudState();

  @override
  List<Object?> get props => const [];
}
