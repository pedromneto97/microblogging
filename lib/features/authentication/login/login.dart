import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../bottom_tab/bottom_tab_container.dart';
import '../register/register.dart';
import '../widgets/password_input.dart';

class Login extends StatefulWidget {
  static const screenName = 'home_screen';

  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void login() {
      if (_formKey.currentState?.validate() == true) {
        BlocProvider.of<AuthenticationBloc>(context).add(
          LoginEvent(
            email: _emailTextEditingController.text,
            password: _passwordTextEditingController.text,
          ),
        );
      }
    }

    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'SEU BLOG',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextFormField(
                            controller: _emailTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              hintText: 'pedromneto97@gmail.com',
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
                          onSubmit: (_) => login(),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: state is AuthenticationInProgressState
                                ? null
                                : login,
                            child: state is AuthenticationInProgressState
                                ? const CircularProgressIndicator()
                                : Text(
                                    'ENTRAR'.toUpperCase(),
                                  ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: state is AuthenticationInProgressState
                              ? null
                              : () => Navigator.of(context)
                                  .pushNamed(Register.screenName),
                          child: Text(
                            'Registrar'.toUpperCase(),
                          ),
                        )
                      ],
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
