import 'package:hive/hive.dart';

import '../models/post.dart';
import '../models/user.dart';

void populateStorage() {
  final userBox = Hive.box<User>('users');
  final postBox = Hive.box<Post>('posts');
  if (userBox.isNotEmpty || postBox.isNotEmpty) {
    return;
  }
  final users = [
    User(
      name: 'Renato',
      email: 'renato@exemplo.com',
      password: '123456',
      id: '86985094-91f6-4a20-8f0d-732360565581',
    ),
    User(
      name: 'Roberto',
      email: 'roberto@exemplo.com',
      password: '123456',
      id: 'fc4b2a85-4bbb-49ec-8adc-a68c5755647d',
    ),
    User(
      name: 'Luciane',
      email: 'lu@exemplo.com',
      password: '123456',
      id: '9edd2a54-2025-45dc-a887-7bfb21787e76',
    ),
    User(
      name: 'Iraci',
      email: 'iraci@exemplo.com',
      password: '123456',
      id: '3a2f4834-368a-45a5-9fb0-8074ba6ad264',
    ),
    User(
      name: 'Pedro',
      email: 'pedro@exemplo.com',
      password: '123456',
      id: 'ff57ef95-8b06-406e-a3d3-16a64a48497a',
    ),
    User(
      name: 'Marieli',
      email: 'marieli@exemplo.com',
      password: '123456',
      id: 'f63096f3-9e8a-472c-a2fb-2f663a68f552',
    ),
  ];

  userBox.addAll(users);

  final posts = [
    Post(
      userId: users.elementAt(5).id,
      dateTime: DateTime(2021, 4, 27),
      text:
          // ignore: lines_longer_than_80_chars
          'neque convallis a cras semper auctor neque vitae tempus quam pellentesque nec nam aliquam sem et tortor consequat id porta nibh venenatis cras sed felis eget velit aliquet sagittis id consectetur purus ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitaee',
      user: users.elementAt(5),
    ),
    Post(
      userId: users.elementAt(0).id,
      dateTime: DateTime(2021, 5, 24, 17, 35),
      text:
          // ignore: lines_longer_than_80_chars
          'faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae semper quis lectus nulla at volutpat diam ut venenatis tellus in metus vulputate eu scelerisque felis',
      user: users.elementAt(0),
    ),
    Post(
      userId: users.elementAt(2).id,
      dateTime: DateTime(2021, 5, 24, 15, 40),
      text:
          // ignore: lines_longer_than_80_chars
          'faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae semper quis lectus nulla at volutpat diam ut venenatis tellus in metus vulputate eu scelerisque felis',
      user: users.elementAt(2),
    ),
    Post(
      userId: users.elementAt(3).id,
      dateTime: DateTime.now(),
      text:
          // ignore: lines_longer_than_80_chars
          'sollicitudin tempor id eu nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit amet risus nullam eget felis eget nunc lobortis mattis aliquam faucibus purus in massa tempor nec feugiat nisl pretium fusce id velit ut tortor pretium viverra suspendisse potenti nullam ac',
      user: users.elementAt(3),
    ),
    Post(
      userId: users.elementAt(5).id,
      dateTime: DateTime(2021, 5, 7, 14, 15),
      text:
          // ignore: lines_longer_than_80_chars
          'habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu dictum varius duis at consectetur lorem donec massa sapien ',
      user: users.elementAt(5),
    ),
    Post(
      userId: users.elementAt(1).id,
      dateTime: DateTime(2021, 03, 15, 22, 30),
      text:
          // ignore: lines_longer_than_80_chars
          'habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper',
      user: users.elementAt(1),
    ),
    Post(
      userId: users.elementAt(3).id,
      dateTime: DateTime(2021, 12, 25, 22, 30),
      text:
          // ignore: lines_longer_than_80_chars
          'pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu',
      user: users.elementAt(3),
    ),
  ];

  posts.sort((a, b) {
    return -a.dateTime.difference(b.dateTime).inMilliseconds;
  });

  print(posts);

  postBox.addAll(posts);
}
