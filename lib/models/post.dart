import 'package:hive/hive.dart';

import 'user.dart';

part 'post.g.dart';

///Post class. If user with an API, could split into two classes (Post and News)
///But it extends [HiveObject], so it's not possible to extend another class
@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final String text;

  @HiveField(3)
  final User user;

  ///Represents the post id. It's not used on News.
  @HiveField(4)
  final String id;

  Post({
    required this.id,
    required this.userId,
    required this.dateTime,
    required this.text,
    required this.user,
  });
}
