import 'package:equatable/equatable.dart';

/// Base class for authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to sign up a new user
class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String? fullName;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.fullName,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword, fullName];
}

/// Event to sign in an existing user
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Event to sign out current user
class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

/// Event to check current session
class CheckSessionEvent extends AuthEvent {
  const CheckSessionEvent();
}

/// Event to reset password
class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}