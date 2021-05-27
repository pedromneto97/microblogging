import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/exceptions.dart';
import '../../../models/user.dart';
import '../../../repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(const InitialAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    try {
      if (event is RegisterEvent) {
        yield const AuthenticationInProgressState();
        await Future.delayed(const Duration(seconds: 2), () {});

        final user = authenticationRepository.registerUser(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        yield AuthenticationSuccessState(user: user);
      } else if (event is LoginEvent) {
        yield const AuthenticationInProgressState();
        await Future.delayed(const Duration(seconds: 2), () {});
        final user = authenticationRepository.login(
          email: event.email,
          password: event.password,
        );
        yield AuthenticationSuccessState(user: user);
      } else if (event is LogoutEvent) {
        await Future.delayed(const Duration(seconds: 1), () {});
        yield const InitialAuthenticationState();
      }
    } on MyException catch (e) {
      yield AuthenticationFailureState(exception: e);
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return AuthenticationSuccessState(
        user: User(
          id: json['id'],
          email: json['email'],
          password: json['password'],
          name: json['name'],
          photoUrl: json['photoUrl'],
        ),
      );
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state is AuthenticationSuccessState) {
      return {
        'id': state.user.id,
        'name': state.user.name,
        'email': state.user.email,
        'password': state.user.password,
        'photoUrl': state.user.photoUrl,
      };
    }
    return null;
  }
}
