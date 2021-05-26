import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

final DateFormat _formatDateTime = DateFormat("dd 'de' MMM 'às' HH:mm");
final DateFormat _formatTime = DateFormat('HH:mm');

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 144,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.user.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateTime.now().difference(post.dateTime).inDays > 0
                        ? _formatDateTime.format(post.dateTime)
                        : _formatTime.format(post.dateTime),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
            Text(
              post.text,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }
}
