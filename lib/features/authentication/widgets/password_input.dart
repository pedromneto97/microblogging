import "package:flutter/material.dart";

class PasswordInput extends StatefulWidget {
  final bool isNewPasswordInput;

  const PasswordInput({
    Key? key,
    this.isNewPasswordInput = false,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isTextObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Senha",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isTextObscured = !isTextObscured;
            });
          },
          icon: Icon(
            isTextObscured
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
          ),
        ),
      ),
      autofillHints: [
        widget.isNewPasswordInput
            ? AutofillHints.newPassword
            : AutofillHints.password
      ],
      keyboardType: TextInputType.visiblePassword,
      obscureText: isTextObscured,
      validator: (value) {
        if (value == null || value.length < 6) {
          return "A senha precisa ter no mínimo 6 caracteres";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
