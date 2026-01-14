import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String id;

  const Category({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  Category copyWith({String? name, String? id}) {
    return Category(id: id ?? this.id, name: name ?? this.name);
  }
}
