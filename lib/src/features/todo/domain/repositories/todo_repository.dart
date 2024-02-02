import 'package:todo_task/src/core/util/result.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Result> insertTodo(Todo todo);
  Future<Result> updateTodo(Todo todo);
  Future<Result> removeTodo(Todo todo);
  Future<Result> getTodoById(String id);
  Future<Result> getAllTodos();
}
