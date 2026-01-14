import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_vault/core/network/network_info.dart';
import 'package:quote_vault/domain/entities/category.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/usecases/quote/get_categories_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/get_quote_of_the_day_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/get_quotes_usecase.dart';
import 'package:quote_vault/domain/usecases/quote/toggle_favorite_usecase.dart';
import 'package:quote_vault/presentation/bloc/home/home_event.dart';
import 'package:quote_vault/presentation/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetQuoteOfTheDayUseCase getQuoteOfTheDayUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetQuotesUseCase getQuotesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final NetworkInfo networkInfo;
  
  int _currentOffset = 0;
  static const int _pageSize = 5;

  HomeBloc({
    required this.getQuoteOfTheDayUseCase,
    required this.getCategoriesUseCase,
    required this.getQuotesUseCase,
    required this.toggleFavoriteUseCase,
    required this.networkInfo,
  }) : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<LoadQuotes>(_onLoadQuotes);
    on<SelectCategory>(_onSelectCategory);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      emit(const HomeOffline());
      return;
    }

    try {
      final quoteOfTheDayResult = await getQuoteOfTheDayUseCase();
      final categoriesResult = await getCategoriesUseCase();
      final quotesResult = await getQuotesUseCase(
        GetQuotesParams(
          limit: _pageSize,
          userId: event.userId,
        ),
      );

      if (categoriesResult.isLeft() || quotesResult.isLeft()) {
        emit(const HomeError('Failed to load data'));
        return;
      }

      final quoteOfTheDay = quoteOfTheDayResult.fold(
        (failure) => null,
        (quote) => quote,
      );

      final categories = categoriesResult.fold(
        (failure) => <Category>[],
        (cats) => cats,
      );

      final quotes = quotesResult.fold(
        (failure) => <Quote>[],
        (q) => q,
      );

      _currentOffset = _pageSize;

      emit(HomeLoaded(
        quoteOfTheDay: quoteOfTheDay,
        categories: categories,
        quotes: quotes,
        hasMoreQuotes: quotes.length >= _pageSize,
        userId: event.userId,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadQuotes(
    LoadQuotes event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;

    if (event.refresh) {
      _currentOffset = 0;
      emit(currentState.copyWith(isLoadingMore: true));
    } else {
      if (!currentState.hasMoreQuotes || currentState.isLoadingMore) return;
      emit(currentState.copyWith(isLoadingMore: true));
    }

    try {
      final result = await getQuotesUseCase(
        GetQuotesParams(
          categoryId: event.categoryId,
          limit: _pageSize,
          offset: event.refresh ? 0 : _currentOffset,
          userId: currentState.userId,
        ),
      );

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (newQuotes) {
          _currentOffset = event.refresh ? _pageSize : _currentOffset + _pageSize;

          final updatedQuotes = event.refresh
              ? newQuotes
              : [...currentState.quotes, ...newQuotes];

          emit(currentState.copyWith(
            quotes: updatedQuotes,
            hasMoreQuotes: newQuotes.length >= _pageSize,
            isLoadingMore: false,
          ));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    _currentOffset = 0;

    emit(currentState.copyWith(
      selectedCategoryId: event.categoryId,
      isLoadingMore: true,
    ));

    try {
      final result = await getQuotesUseCase(
        GetQuotesParams(
          categoryId: event.categoryId,
          limit: _pageSize,
          userId: currentState.userId,
        ),
      );

      result.fold(
        (failure) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (quotes) {
          _currentOffset = _pageSize;

          emit(currentState.copyWith(
            quotes: quotes,
            selectedCategoryId: event.categoryId,
            hasMoreQuotes: quotes.length >= _pageSize,
            isLoadingMore: false,
          ));
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    
    if (currentState.userId == null) return;

    try {
      final result = await toggleFavoriteUseCase(
        ToggleFavoriteParams(
          quoteId: event.quoteId,
          userId: currentState.userId!,
        ),
      );

      result.fold(
        (failure) {},
        (isFavorited) {
          final updatedQuotes = currentState.quotes.map((quote) {
            if (quote.id == event.quoteId) {
              return quote.copyWith(isFavorite: isFavorited);
            }
            return quote;
          }).toList();

          final updatedQuoteOfTheDay = currentState.quoteOfTheDay?.id == event.quoteId
              ? currentState.quoteOfTheDay!.copyWith(isFavorite: isFavorited)
              : currentState.quoteOfTheDay;

          emit(currentState.copyWith(
            quotes: updatedQuotes,
            quoteOfTheDay: updatedQuoteOfTheDay,
          ));
        },
      );
    } catch (e) {}
  }
}
