import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:microblogging/blocs/authentication/authentication/authentication_bloc.dart';
import 'package:microblogging/models/exceptions.dart';
import 'package:microblogging/models/user.dart';
import 'package:microblogging/repository/authentication_repository.dart';
import 'package:uuid/uuid.dart';

import '../mocks.dart';
import '../utils.dart';

void main() {
  const email = 'teste@email.com';
  const name = 'Pedro';
  const password = '123456';
  final id = const Uuid().v4();

  group('Test states', () {
    test('Initial state', () {
      const state = InitialAuthenticationState();

      expect(state.props.isEmpty, isTrue);
    });

    test('In progress state', () {
      const state = AuthenticationInProgressState();

      expect(state.props.isEmpty, isTrue);
    });

    test('Success state', () {
      final user = User(name: name, id: id, email: email);
      final state = AuthenticationSuccessState(user: user);

      expect(state.user, user);

      expect(state.props.isNotEmpty, isTrue);
      expect(state.props[0], user.email);
      expect(state.props[1], user.name);
      expect(state.props[2], user.id);
    });

    test('Failure state', () {
      const exception = UserAlreadyExists(message: 'Usuário já existe');
      const state = AuthenticationFailureState(exception: exception);

      expect(state.exception, exception);

      expect(state.props.isNotEmpty, isTrue);
      expect(state.props[0], exception);
    });
  });

  group('Test event', () {
    test('Register event', () {
      const state = RegisterEvent(name: name, email: email, password: password);

      expect(state.props.isNotEmpty, isTrue);

      expect(state.props[0], name);
      expect(state.props[1], email);
      expect(state.props[2], password);
    });

    test('Login event', () {
      const state = LoginEvent(email: email, password: password);

      expect(state.props.isNotEmpty, isTrue);

      expect(state.props[0], email);
      expect(state.props[1], password);
    });

    test('Logout event', () {
      const state = LogoutEvent();

      expect(state.props.isEmpty, isTrue);
    });
  });

  group('Test bloc', () {
    late final AuthenticationRepository authenticationRepository;
    late AuthenticationBloc bloc;

    final user = User(
      name: name,
      id: id,
      password: password,
      email: email,
    );

    setUpAll(() async {
      HydratedBloc.storage = mockStorage();
      authenticationRepository = MockAuthenticationRepository();
    });

    setUp(() {
      bloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      );
    });

    tearDown(() {
      reset(authenticationRepository);
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'Register event success',
      build: () {
        when(
          () => authenticationRepository.registerUser(
            email: email,
            password: password,
            name: name,
          ),
        ).thenReturn(
          User(
            name: name,
            id: const Uuid().v4(),
            password: password,
            email: email,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const RegisterEvent(
          name: name,
          email: email,
          password: password,
        ),
      ),
      expect: () => [
        const AuthenticationInProgressState(),
        AuthenticationSuccessState(user: user)
      ],
      wait: const Duration(seconds: 3),
    );
  });
}
