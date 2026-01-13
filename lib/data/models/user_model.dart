import 'package:quote_vault/domain/entities/user.dart';

/// User data model for JSON serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.avatarUrl,
    required super.createdAt,
    super.lastSignInAt,
    required super.emailConfirmed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastSignInAt: json['last_sign_in_at'] != null
          ? DateTime.parse(json['last_sign_in_at'] as String)
          : null,
      emailConfirmed: json['email_confirmed_at'] != null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'last_sign_in_at': lastSignInAt?.toIso8601String(),
      'email_confirmed_at': emailConfirmed ? createdAt.toIso8601String() : null,
    };
  }

  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      createdAt: user.createdAt,
      lastSignInAt: user.lastSignInAt,
      emailConfirmed: user.emailConfirmed,
    );
  }
}