import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../models/post.dart';
import '../../repository/post_repository.dart';
import 'bloc/post_crud/post_crud_bloc.dart';

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
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        body: Padding(
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
                                    userId:
                                        (BlocProvider.of<AuthenticationBloc>(
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
          ),
        ),
      ),
    );
  }
}
