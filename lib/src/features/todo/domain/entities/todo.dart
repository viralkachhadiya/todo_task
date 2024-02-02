import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime? createdAtUtc;

  const Todo({required this.id, required this.title, required this.description, required this.createdAtUtc});

  @override
  List<Object?> get props => [id, title, description, createdAtUtc];
}
