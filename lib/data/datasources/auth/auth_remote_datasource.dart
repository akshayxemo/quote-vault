import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for authentication using Supabase
abstract class AuthRemoteDataSource {
  Future<Session> signUp({
    required String email,
    required String password,
    String? fullName,
  });

  Future<Session> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<Session> refreshSession();

  Future<void> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<Session> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );

      if (response.session == null) {
        throw const AuthException('Sign up failed - no session returned');
      }

      return response.session!;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during sign up: ${e.toString()}');
    }
  }

  @override
  Future<Session> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw const AuthException('Sign in failed - no session returned');
      }

      return response.session!;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during sign out: ${e.toString()}');
    }
  }

  @override
  Future<Session> refreshSession() async {
    try {
      final response = await supabaseClient.auth.refreshSession();
      
      if (response.session == null) {
        throw const AuthException('Session refresh failed');
      }

      return response.session!;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during session refresh: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during password reset: ${e.toString()}');
    }
  }
}