import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/exceptions.dart';
import '../../../models/user.dart';
import '../../../repository/register_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
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
      }
    } on Exception catch (e) {
      yield AuthenticationFailureState(exception: e);
    }
  }
}
