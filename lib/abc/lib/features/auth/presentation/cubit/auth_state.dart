part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final User? user;

  const AuthLoaded({required this.user});

  @override
  List<Object> get props => [user!];
}

class UnAuth extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthError extends AuthState{
  final String? message;
  const AuthError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message!];
}

class OtpSent extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PhoneAuth extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
