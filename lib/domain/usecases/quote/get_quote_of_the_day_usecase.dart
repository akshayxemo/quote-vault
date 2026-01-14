import 'package:dartz/dartz.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';

class GetQuoteOfTheDayUseCase {
  final QuoteRepository repository;

  GetQuoteOfTheDayUseCase(this.repository);

  Future<Either<Failure, Quote?>> call() async {
    return await repository.getQuoteOfTheDay();
  }
}
