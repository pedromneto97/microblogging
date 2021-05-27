import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/authentication/authentication/authentication_bloc.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) => Row(
          children: [
            CircleAvatar(
              child: Text(
                (state as AuthenticationSuccessState).user.name[0],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.user.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    state.user.email!,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
