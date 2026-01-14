import 'package:equatable/equatable.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/presentation/bloc/search/search_event.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchOffline extends SearchState {
  const SearchOffline();
}

class SearchLoaded extends SearchState {
  final List<Quote> quotes;
  final String query;
  final SearchType searchType;

  const SearchLoaded({
    required this.quotes,
    required this.query,
    required this.searchType,
  });

  @override
  List<Object?> get props => [quotes, query, searchType];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
