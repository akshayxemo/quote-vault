import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../entities/auth_session.dart';
import '../../core/error/failures.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Sign up with email and password
  Future<Either<Failure, AuthSession>> signUp({
    required String email,
    required String password,
    String? fullName,
  });

  /// Sign in with email and password
  Future<Either<Failure, AuthSession>> signIn({
    required String email,
    required String password,
  });

  /// Sign out current user
  Future<Either<Failure, void>> signOut();

  /// Get current session from local storage
  Future<Either<Failure, AuthSession?>> getCurrentSession();

  /// Save session to local storage
  Future<Either<Failure, void>> saveSession(AuthSession session);

  /// Clear session from local storage
  Future<Either<Failure, void>> clearSession();

  /// Refresh session token
  Future<Either<Failure, AuthSession>> refreshSession();

  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? fullName,
    String? avatarUrl,
  });
}