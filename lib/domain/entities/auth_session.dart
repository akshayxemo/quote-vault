import 'package:equatable/equatable.dart';
import 'user.dart';

/// Authentication session domain entity
class AuthSession extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final User user;
  final String tokenType;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.user,
    this.tokenType = 'bearer',
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  
  bool get isValid => !isExpired && accessToken.isNotEmpty;

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        expiresAt,
        user,
        tokenType,
      ];

  AuthSession copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    User? user,
    String? tokenType,
  }) {
    return AuthSession(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      user: user ?? this.user,
      tokenType: tokenType ?? this.tokenType,
    );
  }
}