import 'package:dartz/dartz.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';
import '../../core/error/failures.dart';

/// Use case for getting current session
class GetCurrentSessionUseCase {
  final AuthRepository repository;

  GetCurrentSessionUseCase(this.repository);

  Future<Either<Failure, AuthSession?>> call() async {
    return await repository.getCurrentSession();
  }
}