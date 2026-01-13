import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';
import '../../core/error/failures.dart';

/// Use case for user sign up
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, AuthSession>> call(SignUpParams params) async {
    // Validate input
    if (params.email.isEmpty) {
      return const Left(ValidationFailure('Email is required'));
    }
    
    if (params.password.isEmpty) {
      return const Left(ValidationFailure('Password is required'));
    }

    if (params.password.length < 8) {
      return const Left(ValidationFailure('Password must be at least 8 characters'));
    }

    if (params.confirmPassword != params.password) {
      return const Left(ValidationFailure('Passwords do not match'));
    }

    // Call repository
    final result = await repository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );

    // Save session if successful
    return result.fold(
      (failure) => Left(failure),
      (session) async {
        final saveResult = await repository.saveSession(session);
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(session),
        );
      },
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final String? fullName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.fullName,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword, fullName];
}