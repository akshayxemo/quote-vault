import 'package:equatable/equatable.dart';

enum SearchType { quote, author }

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQuotes extends SearchEvent {
  final String query;
  final SearchType searchType;
  final String? userId;

  const SearchQuotes({
    required this.query,
    required this.searchType,
    this.userId,
  });

  @override
  List<Object?> get props => [query, searchType, userId];
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}
