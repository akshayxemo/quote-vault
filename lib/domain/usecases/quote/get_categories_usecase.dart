import 'package:dartz/dartz.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/entities/category.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';

class GetCategoriesUseCase {
  final QuoteRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}
