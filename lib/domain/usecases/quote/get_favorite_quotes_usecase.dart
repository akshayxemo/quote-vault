import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';

class GetFavoriteQuotesParams extends Equatable {
  final String userId;
  final int? limit;
  final int? offset;

  const GetFavoriteQuotesParams({
    required this.userId,
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [userId, limit, offset];
}

class GetFavoriteQuotesUseCase {
  final QuoteRepository repository;

  GetFavoriteQuotesUseCase(this.repository);

  Future<Either<Failure, List<Quote>>> call(GetFavoriteQuotesParams params) async {
    return await repository.getFavoriteQuotes(
      userId: params.userId,
      limit: params.limit,
      offset: params.offset,
    );
  }
}
