import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:microblogging/repository/authentication_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockStorage extends Mock implements Storage {}
