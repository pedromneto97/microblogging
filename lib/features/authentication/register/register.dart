import 'package:flutter/material.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crie sua conta'),
      ),
      body: Container(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _emailTextEditingController,
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
                              onSubmit: (_) {
                                if (_formKey.currentState?.validate() == true) {
                                  print(
                                      'E-mail: ${_emailTextEditingController.text}');
                                  print(
                                      'Password: ${_passwordTextEditingController.text}');
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 72.0,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    print(
                                        'E-mail: ${_emailTextEditingController.text}');
                                    print(
                                        'Password: ${_passwordTextEditingController.text}');
                                  }
                                },
                                child: Text(
                                  'REGISTRAR'.toUpperCase(),
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
    );
  }
}
