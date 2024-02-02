import 'package:todo_task/src/core/util/result.dart';
import 'package:todo_task/src/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUsecase {
  final TodoRepository? todoRepository;

  GetAllTodosUsecase(this.todoRepository);

  Future<Result> call() async => todoRepository!.getAllTodos();
}
