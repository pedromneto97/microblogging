import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String password;
  @HiveField(3)
  String? photoUrl;
  @HiveField(5)
  late String id;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    this.photoUrl,
  });
}
