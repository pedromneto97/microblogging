import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../bottom_tab/bottom_tab_container.dart';
import '../widgets/password_input.dart';

class Register extends StatefulWidget {
  static const screenName = 'register_screen';

  const Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _nameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<AuthenticationBloc>(context).add(
          RegisterEvent(
            name: _nameTextEditingController.text,
            password: _passwordTextEditingController.text,
            email: _emailTextEditingController.text,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crie sua conta'),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              BottomTabContainer.screenName,
              (route) => route.settings.name == '/',
            );
          } else if (state is AuthenticationFailureState) {
            showBottomSheet(
                context: context,
                elevation: 2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                builder: (context) {
                  return Container(
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.error,
                          color: Theme.of(context).errorColor,
                          size: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.exception.message,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        },
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 24.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameTextEditingController,
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                ),
                                autofillHints: const [AutofillHints.name],
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O nome é obrigatório';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextFormField(
                                  controller: _emailTextEditingController,
                                  decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                  ),
                                  autofillHints: const [AutofillHints.email],
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
                                            .hasMatch(value)) {
                                      return 'Insira um e-mail válido';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              PasswordInput(
                                controller: _passwordTextEditingController,
                                isNewPasswordInput: true,
                                onSubmit: (_) => submit(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 72.0,
                                ),
                                child: BlocBuilder<AuthenticationBloc,
                                    AuthenticationState>(
                                  builder: (context, state) => ElevatedButton(
                                    onPressed:
                                        state is AuthenticationInProgressState
                                            ? null
                                            : submit,
                                    child:
                                        state is AuthenticationInProgressState
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                'REGISTRAR'.toUpperCase(),
                                              ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
