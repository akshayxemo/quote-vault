import 'package:dartz/dartz.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Sign up with email and password
  Future<Either<Failure, Session>> signUp({
    required String email,
    required String password,
    String? fullName,
  });

  /// Sign in with email and password
  Future<Either<Failure, Session>> signIn({
    required String email,
    required String password,
  });

  /// Sign out current user
  Future<Either<Failure, void>> signOut();

  /// Get current session from local storage
  Future<Either<Failure, Session?>> getCurrentSession();

  /// Save session to local storage
  Future<Either<Failure, void>> saveSession(Session session);

  /// Clear session from local storage
  Future<Either<Failure, void>> clearSession();

  /// Refresh session token
  Future<Either<Failure, Session>> refreshSession();

  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);
}