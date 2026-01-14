import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  final String userId;

  const LoadFavorites({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class LoadMoreFavorites extends FavoritesEvent {
  const LoadMoreFavorites();
}

class RemoveFavorite extends FavoritesEvent {
  final String quoteId;

  const RemoveFavorite(this.quoteId);

  @override
  List<Object?> get props => [quoteId];
}
