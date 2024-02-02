import 'package:todo_task/src/core/util/result.dart';
import 'package:todo_task/src/features/todo/data/data_sources/local_data_source.dart';
import 'package:todo_task/src/features/todo/data/models/todo_model.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final ILocalDataSource? localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<Result> getTodoById(String id) {
    return localDataSource!.getTodoById(id);
  }

  @override
  Future<Result> insertTodo(Todo todo) {
    return localDataSource!.insertTodo(todo as TodoModel);
  }

  @override
  Future<Result> removeTodo(Todo todo) {
    return localDataSource!.removeTodo(todo as TodoModel);
  }

  @override
  Future<Result> getAllTodos() {
    return localDataSource!.getAllTodos();
  }
  
  @override
  Future<Result> updateTodo(Todo todo) {
    return localDataSource!.updateTodo(todo as TodoModel);
  }
}
