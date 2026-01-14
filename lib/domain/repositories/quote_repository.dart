import 'package:dartz/dartz.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/category.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote?>> getQuoteOfTheDay();
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Quote>>> getQuotes({
    String? categoryId,
    int? limit,
    int? offset,
    String? userId,
  });
  Future<Either<Failure, List<Quote>>> getFavoriteQuotes({
    required String userId,
    int? limit,
    int? offset,
  });
  Future<Either<Failure, bool>> toggleFavorite({
    required String quoteId,
    required String userId,
  });
  Future<Either<Failure, List<Quote>>> searchQuotes({
    required String query,
    required SearchType searchType,
    String? userId,
  });
}
