import "package:flutter/material.dart";

import "../widgets/password_input.dart";

class Home extends StatefulWidget {
  static const screenName = "home_screen";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

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
                const Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "SEU BLOG",
                      //             style: Theme.of(context).textTheme.headline2,
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
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            hintText: "pedromneto97@gmail.com",
                          ),
                          autofillHints: [AutofillHints.email],
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r"^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$")
                                    .hasMatch(value)) {
                              return "Insira um e-mail válido";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const PasswordInput(),
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
                            print("Sucesso");
                          }
                        },
                        child: Text(
                          "ENTRAR".toUpperCase(),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "Registrar".toUpperCase(),
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
