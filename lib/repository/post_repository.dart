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

  _GetPostsReturn getPosts({required int page, int pageLength = 4}) {
    final box = Hive.box<Post>('posts');
    final pages = (box.values.length / pageLength).ceil();
    final posts =
        box.values.skip((page - 1) * pageLength).take(pageLength).toList();
    return _GetPostsReturn(
      pages: pages,
      posts: posts,
    );
  }
}

class _GetPostsReturn {
  final int pages;
  final List<Post> posts;

  _GetPostsReturn({
    required this.pages,
    required this.posts,
  });
}
