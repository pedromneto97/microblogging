import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/post.dart';
import '../bottom_tab/bloc/news/news_bloc.dart';

class News extends StatelessWidget {
  const News();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is InitialNewsState) {
        BlocProvider.of<NewsBloc>(context).add(const NewsEventGet());
      }
      if (state is InProgressNewsState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is FailureNewsState) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Theme.of(context).errorColor,
                  size: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    'Ocorreu um erro ao consultar as notícias',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<NewsBloc>(context).add(
                      const NewsEventGet(),
                    );
                  },
                  child: Text(
                    'Aperte aqui para tentar novamente'.toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      if (state is SuccessNewsState) {
        return ListView.builder(
          itemBuilder: (context, index) => PostCard(post: state.news[index]),
          itemExtent: 192,
          itemCount: state.news.length,
        );
      }
      return Container();
    });
  }
}
