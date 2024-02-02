import 'package:todo_task/src/core/util/result.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/domain/repositories/todo_repository.dart';

class InsertTodoUsecase {
  final TodoRepository? todoRepository;

  InsertTodoUsecase(this.todoRepository);

  Future<Result> call(Todo todo) async {
    return todoRepository!.insertTodo(todo);
  }
}
