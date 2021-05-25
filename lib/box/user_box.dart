import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String password;
  @HiveField(3)
  String? photoUrl;
}
