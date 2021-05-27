import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../blocs/authentication/authentication/authentication_bloc.dart';
import '../../repository/news_repository.dart';
import '../../repository/post_repository.dart';
import '../../utils/http_helper.dart';
import '../feed/feed.dart';
import '../menu/menu.dart';
import '../news/news.dart';
import '../posts/posts.dart';
import 'bloc/feed/feed_bloc.dart';
import 'bloc/news/news_bloc.dart';
import 'bloc/posts/posts_bloc.dart';

class BottomTabContainer extends StatefulWidget {
  static const screenName = 'bottom_tab';

  const BottomTabContainer();

  @override
  _BottomTabContainerState createState() => _BottomTabContainerState();
}

const _items = [
  Feed(),
  Posts(),
  News(),
  Menu(),
];

const _titles = ['', 'O que as pessoas andam vendo', 'Últimas notícias', ''];

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PostRepository(),
          lazy: false,
        ),
        RepositoryProvider(
          create: (context) =>
              NewsRepository(httpHelper: HttpHelper(client: Client())),
          lazy: false,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FeedBloc(
              postRepository: RepositoryProvider.of<PostRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => PostsBloc(
              postRepository: RepositoryProvider.of<PostRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc(
              newsRepository: RepositoryProvider.of<NewsRepository>(context),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) => Text(
                index == 0
                    ? 'Bem vindo '
                        '${(state as AuthenticationSuccessState).user.name}'
                    : _titles.elementAt(index),
              ),
            ),
          ),
          body: _items.elementAt(index),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: 'Inicio',
                backgroundColor: Theme.of(context).primaryColor,
                activeIcon: const Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.whatshot_outlined),
                label: 'Postagens',
                backgroundColor: Theme.of(context).primaryColor,
                activeIcon: const Icon(Icons.whatshot_rounded),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.feed_outlined),
                label: 'Novidades',
                backgroundColor: Theme.of(context).primaryColor,
                activeIcon: const Icon(Icons.feed_rounded),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                label: 'Menu',
                backgroundColor: Theme.of(context).primaryColor,
                activeIcon: const Icon(Icons.settings_rounded),
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
