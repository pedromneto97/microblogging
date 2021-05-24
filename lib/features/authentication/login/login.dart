import 'package:flutter/material.dart';

import '../widgets/password_input.dart';

class Home extends StatefulWidget {
  static const screenName = 'home_screen';

  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      body: Container(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      PasswordInput(
                        controller: _passwordTextEditingController,
                        onSubmit: (_) {
                          if (_formKey.currentState?.validate() == true) {
                            print(
                                'E-mail: ${_emailTextEditingController.text}');
                            print(
                                'Password: ${_passwordTextEditingController.text}');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            print(
                                'E-mail: ${_emailTextEditingController.text}');
                            print(
                                'Password: ${_passwordTextEditingController.text}');
                          }
                        },
                        child: Text(
                          'ENTRAR'.toUpperCase(),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Registrar'.toUpperCase(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
