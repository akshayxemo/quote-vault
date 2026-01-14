import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';

class SearchQuotesParams extends Equatable {
  final String query;
  final SearchType searchType;
  final String? userId;

  const SearchQuotesParams({
    required this.query,
    required this.searchType,
    this.userId,
  });

  @override
  List<Object?> get props => [query, searchType, userId];
}

class SearchQuotesUseCase {
  final QuoteRepository repository;

  SearchQuotesUseCase(this.repository);

  Future<Either<Failure, List<Quote>>> call(SearchQuotesParams params) async {
    return await repository.searchQuotes(
      query: params.query,
      searchType: params.searchType,
      userId: params.userId,
    );
  }
}
