import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quote_vault/core/error/failures.dart';
import 'package:quote_vault/domain/repositories/quote_repository.dart';

class ToggleFavoriteParams extends Equatable {
  final String quoteId;
  final String userId;

  const ToggleFavoriteParams({
    required this.quoteId,
    required this.userId,
  });

  @override
  List<Object?> get props => [quoteId, userId];
}

class ToggleFavoriteUseCase {
  final QuoteRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> call(ToggleFavoriteParams params) async {
    return await repository.toggleFavorite(
      quoteId: params.quoteId,
      userId: params.userId,
    );
  }
}
