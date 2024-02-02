import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel(
      {required String? id,
      required String? title,
      required String? description,
      required DateTime? createdAtUtc})
      : super(
            id: id,
            title: title,
            description: description,
            createdAtUtc: createdAtUtc);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createdAtUtc: json['createdAtUtc']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAtUtc": createdAtUtc
    };
  }
}
