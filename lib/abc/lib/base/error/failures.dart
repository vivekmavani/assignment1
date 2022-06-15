import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({this.code = 400, String? message})
      : super(message: message ?? 'Oops, something wrong');

  final dynamic code;
}

class CacheFailure extends Failure {
  const CacheFailure() : super(message: 'Oops, something wrong');
}


