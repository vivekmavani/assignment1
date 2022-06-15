// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../base/error/failures.dart';




abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?>? call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

