import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  final String message;

  const Exception({
    required this.message,
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
