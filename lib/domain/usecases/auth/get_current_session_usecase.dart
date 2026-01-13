import 'package:dartz/dartz.dart';
import 'package:quote_vault/domain/repositories/auth/auth_repository.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Use case for getting current session
class GetCurrentSessionUseCase {
  final AuthRepository repository;

  GetCurrentSessionUseCase(this.repository);

  Future<Either<Failure, Session?>> call() async {
    return await repository.getCurrentSession();
  }
}