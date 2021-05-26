import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../repository/post_repository.dart';
import 'bloc/feed/feed_bloc.dart';
import 'feed/feed.dart';

class BottomTabContainer extends StatefulWidget {
  static const screenName = 'bottom_tab';

  const BottomTabContainer();

  @override
  _BottomTabContainerState createState() => _BottomTabContainerState();
}

class _BottomTabContainerState extends State<BottomTabContainer> {
  int index = 0;

  void onPressBottomTab(int value) {
    if (value != index) {
      setState(() {
        index = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(),
      lazy: false,
      child: BlocProvider(
        create: (context) => FeedBloc(
          postRepository: RepositoryProvider.of<PostRepository>(context),
        ),
        lazy: false,
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) => Text(
                'Bem vindo ${(state as AuthenticationSuccessState).user.name}!',
              ),
            ),
          ),
          body: const Feed(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.business),
                label: 'Business',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.school),
                label: 'School',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
            onTap: onPressBottomTab,
            iconSize: 24,
          ),
        ),
      ),
    );
  }
}
