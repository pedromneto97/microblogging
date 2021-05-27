import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/post.dart';
import '../../../repository/news_repository.dart';
import '../../../widgets/post.dart';

class News extends StatelessWidget {
  const News();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: (snapshot.data as List<Post>)
                  .map((post) => PostCard(post: post))
                  .toList(),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: RepositoryProvider.of<NewsRepository>(context).getNews(),
    );
  }
}
