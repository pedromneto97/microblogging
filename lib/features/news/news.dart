import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microblogging/widgets/alert_widget.dart';

import '../../../widgets/post.dart';
import '../../blocs/news/news_bloc.dart';

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
        return AlertWidget(
          iconColor: Theme.of(context).errorColor,
          text: 'Ocorreu um erro ao consultar as notícias',
          onTap: () {
            BlocProvider.of<NewsBloc>(context).add(
              const NewsEventGet(),
            );
          },
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
