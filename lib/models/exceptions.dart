import 'package:equatable/equatable.dart';

abstract class MyException extends Equatable implements Exception {
  final String message;

  const MyException({
    this.message = '',
  });

  @override
  List<String> get props => [message];
}

class UserAlreadyExists extends MyException {
  const UserAlreadyExists({
    required String message,
  }) : super(
          message: message,
        );
}

class UserDoesNotExists extends MyException {
  const UserDoesNotExists({
    required String message,
  }) : super(
          message: message,
        );
}

class BadRequest extends MyException {
  const BadRequest();
}

class ServerError extends MyException {
  const ServerError();
}

class NoInternet extends MyException {
  const NoInternet();
}
