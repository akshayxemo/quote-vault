import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/repositories/auth/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase(this.repository);

  Future<Either<Failure, Session>> call(SignInParams params) async {
    final result = await repository.signIn(
      email: params.email,
      password: params.password,
    );

    return result.fold(
      (failure) => Left(failure),
      (session) async {
        final saveResult = await repository.saveSession(session);
        return saveResult.fold(
          (failure) => Left(failure),
          (_) => Right(session),
        );
      },
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}