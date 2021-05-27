import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  final String message;

  const Exception({
    this.message = '',
  });

  @override
  List<String> get props => [message];
}

class UserAlreadyExists extends Exception {
  const UserAlreadyExists({
    required String message,
  }) : super(
          message: message,
        );
}

class UserDoesNotExists extends Exception {
  const UserDoesNotExists({
    required String message,
  }) : super(
          message: message,
        );
}

class BadRequest extends Exception {
  const BadRequest();
}

class ServerError extends Exception {
  const ServerError();
}

class NoInternet extends Exception {
  const NoInternet();
}
