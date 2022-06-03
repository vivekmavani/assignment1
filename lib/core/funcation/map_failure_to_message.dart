import 'package:assignment1/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case RemoteFailure:
      return "Remote Failure";
    default:
      return 'Unexpected Error';
  }
}