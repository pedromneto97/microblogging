import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? photoUrl;
  @HiveField(5)
  late String id;

  User({
    required this.name,
    this.email,
    this.password,
    required this.id,
    this.photoUrl,
  });

  String get firstName => name.split(' ').first;
}
