import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Cache failure');
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Network failure');
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server failure');
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
