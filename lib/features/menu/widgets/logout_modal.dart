import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../../widgets/my_dialog.dart';
import '../../authentication/login/login.dart';

class LogoutModal extends StatelessWidget {
  const LogoutModal();

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Deseja realmente sair?',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('NÃO'),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.screenName,
                          (route) => route.settings.name == '/',
                        );
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          const LogoutEvent(),
                        );
                      },
                      child: const Text('SIM'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
