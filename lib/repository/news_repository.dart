import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';
import '../models/user.dart';
import '../utils/http_helper.dart';

class NewsRepository {
  final HttpHelper httpHelper;

  const NewsRepository._({required this.httpHelper});

  static NewsRepository? _instance;

  factory NewsRepository({required HttpHelper httpHelper}) {
    _instance ??= NewsRepository._(httpHelper: httpHelper);
    return _instance as NewsRepository;
  }

  Future<List<Post>> getNews() async {
    final data = await httpHelper
        .get('https://gb-mobile-app-teste.s3.amazonaws.com/data.json');

    final posts = await compute(_mapNews, data);
    print('user');
    print(posts[0].user.name);
    return posts;
  }
}

List<Post> _mapNews(String data) {
  final parsedData = json.decode(data);
  final users = <User>[];
  return (parsedData['news'] as List<dynamic>).map((e) {
    final user = users.firstWhere(
      (user) => user.name == e['user']['name'],
      orElse: () {
        final user = User(
          name: e['user']['name'],
          id: const Uuid().v4(),
          photoUrl: e['user']['profile_picture'],
        );
        users.add(user);

        return user;
      },
    );

    return Post(
      userId: user.id,
      dateTime: DateTime.parse(e['message']['created_at']),
      text: e['message']['content'],
      user: user,
    );
  }).toList();
}
