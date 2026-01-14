import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_vault/core/network/network_info.dart';
import 'package:quote_vault/domain/usecases/quote/search_quotes_usecase.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';
import 'package:quote_vault/presentation/bloc/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchQuotesUseCase searchQuotesUseCase;
  final NetworkInfo networkInfo;

  SearchBloc({
    required this.searchQuotesUseCase,
    required this.networkInfo,
  }) : super(const SearchInitial()) {
    on<SearchQuotes>(_onSearchQuotes);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchQuotes(
    SearchQuotes event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(const SearchLoading());

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      emit(const SearchOffline());
      return;
    }

    try {
      final result = await searchQuotesUseCase(
        SearchQuotesParams(
          query: event.query,
          searchType: event.searchType,
          userId: event.userId,
        ),
      );

      result.fold(
        (failure) => emit(SearchError(failure.toString())),
        (quotes) => emit(SearchLoaded(
          quotes: quotes,
          query: event.query,
          searchType: event.searchType,
        )),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchInitial());
  }
}
