part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<String> get props => [name, email, password];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<String> get props => [email, password];
}

class LogoutEvent extends AuthenticationEvent {
  const LogoutEvent();

  @override
  List<dynamic> get props => const [];
}
