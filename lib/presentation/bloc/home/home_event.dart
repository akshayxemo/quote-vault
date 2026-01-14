import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {
  final String? userId;

  const LoadHomeData({this.userId});

  @override
  List<Object?> get props => [userId];
}

class LoadQuotes extends HomeEvent {
  final String? categoryId;
  final bool refresh;

  const LoadQuotes({
    this.categoryId,
    this.refresh = false,
  });

  @override
  List<Object?> get props => [categoryId, refresh];
}

class SelectCategory extends HomeEvent {
  final String? categoryId;

  const SelectCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class ToggleFavorite extends HomeEvent {
  final String quoteId;

  const ToggleFavorite(this.quoteId);

  @override
  List<Object?> get props => [quoteId];
}
