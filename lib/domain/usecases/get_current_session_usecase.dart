import 'package:dartz/dartz.dart';
import 'package:quote_vault/domain/entities/auth_session.dart';
import 'package:quote_vault/domain/repositories/auth_repository.dart';
import 'package:quote_vault/core/error/failures.dart';

/// Use case for getting current session
class GetCurrentSessionUseCase {
  final AuthRepository repository;

  GetCurrentSessionUseCase(this.repository);

  Future<Either<Failure, AuthSession?>> call() async {
    return await repository.getCurrentSession();
  }
}