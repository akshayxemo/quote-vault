import 'package:dartz/dartz.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/data/datasources/quote_remote_datasource.dart';
import 'package:quote_vault/domain/entities/category.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Quote?>> getQuoteOfTheDay({String? userId}) async {
    try {
      final quote = await remoteDataSource.getQuoteOfTheDay(userId: userId);
      return Right(quote);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> getQuotes({
    String? categoryId,
    int? limit,
    int? offset,
    String? userId,
  }) async {
    try {
      final quotes = await remoteDataSource.getQuotes(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
        userId: userId,
      );
      return Right(quotes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> getFavoriteQuotes({
    required String userId,
    int? limit,
    int? offset,
  }) async {
    try {
      final quotes = await remoteDataSource.getFavoriteQuotes(
        userId: userId,
        limit: limit,
        offset: offset,
      );
      return Right(quotes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite({
    required String quoteId,
    required String userId,
  }) async {
    try {
      final isFavorited = await remoteDataSource.toggleFavorite(
        quoteId: quoteId,
        userId: userId,
      );
      return Right(isFavorited);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Quote>>> searchQuotes({
    required String query,
    required SearchType searchType,
    String? userId,
  }) async {
    try {
      final quotes = await remoteDataSource.searchQuotes(
        query: query,
        searchType: searchType,
        userId: userId,
      );
      return Right(quotes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
