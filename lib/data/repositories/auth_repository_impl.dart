import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:quote_vault/domain/repositories/auth/auth_repository.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/data/datasources/auth/auth_remote_datasource.dart';
import 'package:quote_vault/data/datasources/auth/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Session>> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final session = await remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return Right(session);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(session);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      await localDataSource.clearSession();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Session?>> getCurrentSession() async {
    try {
      final session = await localDataSource.getSession();
      return Right(session);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSession(Session session) async {
    try {
      // final sessionModel = AuthSessionModel.fromDomain(session);
      await localDataSource.saveSession(session);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSession() async {
    try {
      await localDataSource.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> refreshSession() async {
    try {
      final session = await remoteDataSource.refreshSession();
      return Right(session);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await remoteDataSource.resetPassword(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, code: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}