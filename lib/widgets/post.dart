import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';
import '../utils/date_utils.dart';

final DateFormat _formatDateTime = DateFormat("dd 'de' MMM 'às' HH:mm");
final DateFormat _formatTime = DateFormat('HH:mm');

class PostCard extends StatelessWidget {
  final Post post;
  final bool useFirstName;
  final void Function()? onTap;

  const PostCard({
    Key? key,
    required this.post,
    this.useFirstName = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (post.user.photoUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    post.user.photoUrl!,
                    errorBuilder: (context, _, __) {
                      return CircleAvatar(
                        child: Container(
                          child: Text(post.user.name[0]),
                        ),
                      );
                    },
                  ),
                ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            useFirstName ? post.user.firstName : post.user.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            !isToday(post.dateTime)
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
            ],
          ),
        ),
      ),
    );
  }
}
