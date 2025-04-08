part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedIn extends AuthState {
  final User? user;
  const AuthLoggedIn({required this.user});
}

class AuthLoggedOut extends AuthState {

  
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}

class AuthVerificationSent extends AuthState {
  final User? user;
 const  AuthVerificationSent({required this.user});
}

final class PasswordResetEmailSent extends AuthState {
  final String message;
  const PasswordResetEmailSent({required this.message});

  @override
  List<Object> get props => [message];
}
