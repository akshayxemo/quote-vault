import '../../domain/entities/auth_session.dart';
import 'user_model.dart';

/// Auth session data model for JSON serialization
class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresAt,
    required super.user,
    super.tokenType,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(json['expires_at'] as int),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.millisecondsSinceEpoch,
      'user': (user as UserModel).toJson(),
      'token_type': tokenType,
    };
  }

  factory AuthSessionModel.fromDomain(AuthSession session) {
    return AuthSessionModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
      expiresAt: session.expiresAt,
      user: session.user,
      tokenType: session.tokenType,
    );
  }
}