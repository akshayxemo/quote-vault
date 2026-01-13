import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quote_vault/data/models/auth_session_model.dart';

/// Local data source for authentication session storage
abstract class AuthLocalDataSource {
  Future<AuthSessionModel?> getSession();
  Future<void> saveSession(AuthSessionModel session);
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _sessionKey = 'auth_session';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AuthSessionModel?> getSession() async {
    try {
      final sessionJson = sharedPreferences.getString(_sessionKey);
      if (sessionJson == null) return null;

      final sessionMap = json.decode(sessionJson) as Map<String, dynamic>;
      final session = AuthSessionModel.fromJson(sessionMap);

      // Check if session is expired
      if (session.isExpired) {
        await clearSession();
        return null;
      }

      return session;
    } catch (e) {
      // If there's any error parsing the session, clear it
      await clearSession();
      return null;
    }
  }

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    try {
      final sessionJson = json.encode(session.toJson());
      await sharedPreferences.setString(_sessionKey, sessionJson);
    } catch (e) {
      throw Exception('Failed to save session: ${e.toString()}');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await sharedPreferences.remove(_sessionKey);
    } catch (e) {
      throw Exception('Failed to clear session: ${e.toString()}');
    }
  }
}