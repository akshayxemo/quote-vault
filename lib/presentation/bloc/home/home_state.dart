import 'package:equatable/equatable.dart';
import 'package:quote_vault/domain/entities/quote.dart';
import 'package:quote_vault/domain/entities/category.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeOffline extends HomeState {
  const HomeOffline();
}

class HomeLoaded extends HomeState {
  final Quote? quoteOfTheDay;
  final List<Category> categories;
  final List<Quote> quotes;
  final String? selectedCategoryId;
  final bool hasMoreQuotes;
  final bool isLoadingMore;
  final String? userId;

  const HomeLoaded({
    this.quoteOfTheDay,
    required this.categories,
    required this.quotes,
    this.selectedCategoryId,
    this.hasMoreQuotes = true,
    this.isLoadingMore = false,
    this.userId,
  });

  HomeLoaded copyWith({
    Object? quoteOfTheDay = const _Undefined(),
    List<Category>? categories,
    List<Quote>? quotes,
    Object? selectedCategoryId = const _Undefined(),
    bool? hasMoreQuotes,
    bool? isLoadingMore,
    String? userId,
  }) {
    return HomeLoaded(
      quoteOfTheDay: quoteOfTheDay == const _Undefined()
          ? this.quoteOfTheDay
          : quoteOfTheDay as Quote?,
      categories: categories ?? this.categories,
      quotes: quotes ?? this.quotes,
      selectedCategoryId: selectedCategoryId == const _Undefined()
          ? this.selectedCategoryId
          : selectedCategoryId as String?,
      hasMoreQuotes: hasMoreQuotes ?? this.hasMoreQuotes,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        quoteOfTheDay,
        categories,
        quotes,
        selectedCategoryId,
        hasMoreQuotes,
        isLoadingMore,
        userId,
      ];
}

class _Undefined {
  const _Undefined();
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
