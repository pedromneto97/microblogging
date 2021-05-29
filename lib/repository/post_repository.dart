import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';
import '../models/user.dart';

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

  _GetPostsReturn getPosts({
    required int page,
    int pageLength = 4,
    String? userId,
  }) {
    var box = Hive.box<Post>('posts').values;
    if (userId != null) {
      box = box.where((element) => element.userId == userId);
    }
    final pages = (box.length / pageLength).ceil();
    final posts = box.skip((page - 1) * pageLength).take(pageLength).toList();
    return _GetPostsReturn(
      pages: pages,
      posts: posts,
    );
  }

  Post createPost({required String text, required String userId}) {
    final user = Hive.box<User>('users').values.firstWhere(
          (user) => user.id == userId,
        );
    final post = Post(
      id: const Uuid().v4(),
      userId: userId,
      dateTime: DateTime.now(),
      text: text,
      user: user,
    );
    Hive.box<Post>('posts').add(
      post,
    );
    return post;
  }

  Post putPost({required String text, required String id}) {
    final post = Hive.box<Post>('posts').values.firstWhere(
          (post) => post.id == id,
        );
    post.text = text;
    post.save();
    return post;
  }

  void removePost({required String id}) {
    final post = Hive.box<Post>('posts').values.firstWhere(
          (post) => post.id == id,
        );
    post.delete();
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
