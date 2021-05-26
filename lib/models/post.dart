import 'package:hive/hive.dart';

import 'user.dart';

part 'post.g.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final DateTime dateTime;
  @HiveField(2)
  final String text;

  @HiveField(3)
  late User user;

  Post({
    required this.userId,
    required this.dateTime,
    required this.text,
    required this.user,
  });
}
