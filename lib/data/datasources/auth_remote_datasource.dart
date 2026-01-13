import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase show User;
import 'package:quote_vault/data/models/auth_session_model.dart';
import 'package:quote_vault/data/models/user_model.dart';

/// Remote data source for authentication using Supabase
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> signUp({
    required String email,
    required String password,
    String? fullName,
  });

  Future<AuthSessionModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<AuthSessionModel> refreshSession();

  Future<void> resetPassword(String email);

  Future<UserModel> updateProfile({
    String? fullName,
    String? avatarUrl,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<AuthSessionModel> signUp({
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

      return _mapSessionToModel(response.session!);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during sign up: ${e.toString()}');
    }
  }

  @override
  Future<AuthSessionModel> signIn({
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

      return _mapSessionToModel(response.session!);
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
  Future<AuthSessionModel> refreshSession() async {
    try {
      final response = await supabaseClient.auth.refreshSession();
      
      if (response.session == null) {
        throw const AuthException('Session refresh failed');
      }

      return _mapSessionToModel(response.session!);
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

  @override
  Future<UserModel> updateProfile({
    String? fullName,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

      final response = await supabaseClient.auth.updateUser(
        UserAttributes(data: updates),
      );

      if (response.user == null) {
        throw const AuthException('Profile update failed');
      }

      return _mapUserToModel(response.user!);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Unexpected error during profile update: ${e.toString()}');
    }
  }

  AuthSessionModel _mapSessionToModel(Session session) {
    return AuthSessionModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      expiresAt: DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000),
      user: _mapUserToModel(session.user),
      tokenType: session.tokenType,
    );
  }

  UserModel _mapUserToModel(supabase.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(user.createdAt),
      lastSignInAt: user.lastSignInAt != null 
          ? DateTime.parse(user.lastSignInAt!)
          : null,
      emailConfirmed: user.emailConfirmedAt != null,
    );
  }
}