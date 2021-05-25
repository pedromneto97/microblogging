import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });

  @override
  List<String?> get props => [name, email, password, photoUrl];
}
