part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  const InitialAuthenticationState();

  @override
  // TODO: implement props
  List<Object?> get props => const [];
}

class AuthenticationInProgressState extends AuthenticationState {
  const AuthenticationInProgressState();

  @override
  List<Object?> get props => const [];
}

class AuthenticationSuccessState extends AuthenticationState {
  final User user;

  const AuthenticationSuccessState({
    required this.user,
  });

  @override
  List<String?> get props => [user.email, user.name, user.id];
}

class AuthenticationFailureState extends AuthenticationState {
  final MyException exception;

  const AuthenticationFailureState({
    required this.exception,
  });

  @override
  List<MyException> get props => [exception];
}
