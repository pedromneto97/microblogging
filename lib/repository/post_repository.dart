import 'package:hive/hive.dart';

import '../models/post.dart';

class PostRepository {
  const PostRepository._();

  static PostRepository? _instance;

  factory PostRepository() {
    _instance ??= const PostRepository._();
    return _instance as PostRepository;
  }

  List<Post> getFriendsPosts() {
    const friendsIds = [
      '86985094-91f6-4a20-8f0d-732360565581',
      'f63096f3-9e8a-472c-a2fb-2f663a68f552'
    ];
    final box = Hive.box<Post>('posts');
    final posts = box.values
        .where((element) => friendsIds.contains(element.userId))
        .take(3);
    return posts.toList();
  }
}
