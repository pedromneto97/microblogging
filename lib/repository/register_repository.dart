import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../box/user_box.dart';
import '../models/exceptions.dart';
import '../models/user.dart';

class AuthenticationRepository {
  final Box<UserBox> box;

  const AuthenticationRepository._({
    required this.box,
  });

  static AuthenticationRepository? _instance;

  factory AuthenticationRepository({required Box<UserBox> box}) {
    _instance ??= AuthenticationRepository._(box: box);
    return _instance as AuthenticationRepository;
  }

  User registerUser({
    required String email,
    required String password,
    required String name,
  }) {
    final filteredUsers = box.values
        .where((user) => user.email == email && user.password == password);
    if (filteredUsers.isNotEmpty) {
      throw const UserAlreadyExists(message: 'Usuário já cadastrado');
    }

    final id = const Uuid().v4();
    box.add(
      UserBox()
        ..name = name
        ..password = password
        ..email = email
        ..id = id,
    );

    return User(
      id: id,
      name: name,
      email: email,
      password: password,
    );
  }

  User login({
    required String email,
    required String password,
  }) {
    final filteredUsers = box.values
        .where((user) => user.email == email && user.password == password);

    if (filteredUsers.isEmpty) {
      throw const UserDoesNotExists(message: 'Usuário não cadastrado');
    }

    final user = filteredUsers.first;

    return User(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }
}
