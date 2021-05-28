import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/authentication/authentication/authentication_bloc.dart';
import '../authentication/login/login.dart';
import '../posts/my_posts.dart';
import 'widgets/menu_header.dart';
import 'widgets/menu_tile.dart';

class Menu extends StatelessWidget {
  const Menu();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const MenuHeader(),
          const Divider(
            thickness: 1,
          ),
          MenuTile(
            icon: Icons.feed_rounded,
            label: 'Meus Posts',
            onTap: () {
              Navigator.of(context).pushNamed(
                MyPosts.screenName,
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
          MenuTile(
            icon: Icons.logout_rounded,
            label: 'Sair',
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Login.screenName,
                (route) => route.settings.name == '/',
              );
              BlocProvider.of<AuthenticationBloc>(context).add(
                const LogoutEvent(),
              );
            },
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
