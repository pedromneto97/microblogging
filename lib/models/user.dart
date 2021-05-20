class User {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  const User({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
