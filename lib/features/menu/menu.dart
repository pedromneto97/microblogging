import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../posts/my_posts.dart';
import 'widgets/logout_modal.dart';
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
            onTap: () => showDialog(
              context: context,
              builder: (context) => const LogoutModal(),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
