import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../models/post.dart';
import '../../repository/post_repository.dart';
import '../bottom_tab/bottom_tab_container.dart';
import 'bloc/post_crud/post_crud_bloc.dart';
import 'my_posts.dart';

class PostScreen extends StatefulWidget {
  static const screenName = 'post_screen';
  final Post? post;

  const PostScreen({
    Key? key,
    this.post,
  }) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final TextEditingController _textEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.post?.text,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCrudBloc(
        postRepository: RepositoryProvider.of<PostRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.post == null ? 'Criar novo post' : 'Editando post'),
        ),
        body: BlocListener<PostCrudBloc, PostCrudState>(
          listener: (context, state) {
            if (state is SuccessPostCrudState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                MyPosts.screenName,
                ModalRoute.withName(BottomTabContainer.screenName),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Text(
                          'O que você está pensando?'.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      TextFormField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'Texto',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        maxLines: 7,
                        maxLength: 280,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return 'O texto é obrigatório';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if (widget.post != null)
                        Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: OutlinedButton(
                              onPressed: () =>
                                  BlocProvider.of<PostCrudBloc>(context).add(
                                PostCrudEventRemove(id: widget.post!.id),
                              ),
                              child: const Text('APAGAR'),
                            ),
                          ),
                        ),
                      BlocBuilder<PostCrudBloc, PostCrudState>(
                        builder: (context, state) {
                          if (state is InProgressPostCrudState) {
                            return const ElevatedButton(
                              onPressed: null,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<PostCrudBloc>(context).add(
                                  widget.post == null
                                      ? PostCrudEventCreate(
                                          text: _textEditingController.text,
                                          userId: (BlocProvider.of<
                                                  AuthenticationBloc>(
                                            context,
                                          ).state as AuthenticationSuccessState)
                                              .user
                                              .id,
                                        )
                                      : PostCrudEventEdit(
                                          id: widget.post!.id,
                                          text: _textEditingController.text,
                                        ),
                                );
                              }
                            },
                            child: Text(
                              widget.post == null ? 'PUBLICAR' : 'EDITAR',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
