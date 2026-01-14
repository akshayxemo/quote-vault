import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String id;
  final String text;
  final String author;
  final String category;
  final bool isFavorite;
  final DateTime createdAt;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    required this.isFavorite,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, text, author, category, isFavorite, createdAt];

  Quote copyWith({
    String? id, 
    String? text, 
    String? author, 
    String? category, 
    Object? isFavorite = const _Undefined(),
    DateTime? createdAt,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      category: category ?? this.category,
      isFavorite: isFavorite == const _Undefined()
          ? this.isFavorite
          : isFavorite as bool,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class _Undefined {
  const _Undefined();
}
