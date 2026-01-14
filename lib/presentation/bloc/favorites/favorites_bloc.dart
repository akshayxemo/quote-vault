import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_vault/core/network/network_info.dart';
import 'package:quote_vault/domain/usecases/quote/get_favorite_quotes_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/toggle_favorite_usecase.dart';
import 'package:quote_vault/presentation/bloc/favorites/favorites_event.dart';
import 'package:quote_vault/presentation/bloc/favorites/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteQuotesUseCase getFavoriteQuotesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final NetworkInfo networkInfo;

  int _currentOffset = 0;
  static const int _pageSize = 10;

  FavoritesBloc({
    required this.getFavoriteQuotesUseCase,
    required this.toggleFavoriteUseCase,
    required this.networkInfo,
  }) : super(const FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<LoadMoreFavorites>(_onLoadMoreFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      emit(const FavoritesOffline());
      return;
    }

    try {
      _currentOffset = 0;
      final result = await getFavoriteQuotesUseCase(
        GetFavoriteQuotesParams(
          userId: event.userId,
          limit: _pageSize,
        ),
      );

      result.fold(
        (failure) => emit(FavoritesError(failure.toString())),
        (quotes) {
          _currentOffset = _pageSize;
          emit(FavoritesLoaded(
            quotes: quotes,
            userId: event.userId,
            hasMore: quotes.length >= _pageSize,
          ));
        },
      );
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onLoadMoreFavorites(
    LoadMoreFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesLoaded) return;

    final currentState = state as FavoritesLoaded;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final result = await getFavoriteQuotesUseCase(
        GetFavoriteQuotesParams(
          userId: currentState.userId,
          limit: _pageSize,
          offset: _currentOffset,
        ),
      );

      result.fold(
        (failure) => emit(currentState.copyWith(isLoadingMore: false)),
        (newQuotes) {
          _currentOffset += _pageSize;
          emit(currentState.copyWith(
            quotes: [...currentState.quotes, ...newQuotes],
            hasMore: newQuotes.length >= _pageSize,
            isLoadingMore: false,
          ));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesLoaded) return;

    final currentState = state as FavoritesLoaded;

    try {
      final result = await toggleFavoriteUseCase(
        ToggleFavoriteParams(
          quoteId: event.quoteId,
          userId: currentState.userId,
        ),
      );

      result.fold(
        (failure) {},
        (isFavorited) {
          final updatedQuotes = currentState.quotes
              .where((quote) => quote.id != event.quoteId)
              .toList();

          emit(currentState.copyWith(quotes: updatedQuotes));
        },
      );
    } catch (e) {}
  }
}
