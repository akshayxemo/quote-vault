import 'package:equatable/equatable.dart';
import 'package:quote_vault/domain/entities/quote.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesOffline extends FavoritesState {
  const FavoritesOffline();
}

class FavoritesLoaded extends FavoritesState {
  final List<Quote> quotes;
  final bool hasMore;
  final bool isLoadingMore;
  final String userId;

  const FavoritesLoaded({
    required this.quotes,
    required this.userId,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  FavoritesLoaded copyWith({
    List<Quote>? quotes,
    bool? hasMore,
    bool? isLoadingMore,
    String? userId,
  }) {
    return FavoritesLoaded(
      quotes: quotes ?? this.quotes,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [quotes, hasMore, isLoadingMore, userId];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
