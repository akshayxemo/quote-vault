import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';

class GetQuotesParams extends Equatable {
  final String? categoryId;
  final int? limit;
  final int? offset;
  final String? userId;

  const GetQuotesParams({
    this.categoryId,
    this.limit,
    this.offset,
    this.userId,
  });

  @override
  List<Object?> get props => [categoryId, limit, offset, userId];
}

class GetQuotesUseCase {
  final QuoteRepository repository;

  GetQuotesUseCase(this.repository);

  Future<Either<Failure, List<Quote>>> call(GetQuotesParams params) async {
    return await repository.getQuotes(
      categoryId: params.categoryId,
      limit: params.limit,
      offset: params.offset,
      userId: params.userId,
    );
  }
}
