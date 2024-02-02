import 'package:hive/hive.dart';
import 'package:todo_task/src/core/util/result.dart';
import 'package:todo_task/src/features/todo/data/models/todo_model.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';

abstract class ILocalDataSource {
  Future<Result> getTodoById(String id);
  Future<Result> insertTodo(TodoModel todo);
  Future<Result> updateTodo(TodoModel todo);
  Future<Result> removeTodo(TodoModel todo);
  Future<Result> getAllTodos();
}

class LocalDataSource implements ILocalDataSource {
  final HiveInterface? hiveInterface;

  LocalDataSource(this.hiveInterface);

  @override
  Future<Result> getTodoById(String? id) async {
    final todoBox = await hiveInterface!.openBox("TodoTaskBox");

    final todo = await todoBox.get(id);
    return Result.completed(todo as Todo?);
  }

  @override
  Future<Result> insertTodo(TodoModel todo) async {
    final todoBox = await hiveInterface!.openBox("TodoTaskBox");
    await todoBox.put(todo.id, todo);
    return Result.completed(todo.id);
  }

  @override
  Future<Result> removeTodo(TodoModel todo) async {
    final todoBox = await hiveInterface!.openBox("TodoTaskBox");

    await todoBox.delete(todo.id);
    return Result.completed("Todo has been well removed");
  }

  @override
  Future<Result> getAllTodos() async {
    final todoBox = await hiveInterface!.openBox("TodoTaskBox");

    final todos = todoBox.values.toList().cast<Todo>();

    return Result.completed(todos);
  }

  @override
  Future<Result> updateTodo( TodoModel todo) async {
    print("updating.....");
    final todoBox = await hiveInterface!.openBox("TodoTaskBox");

    //await todoBox.putAt(index, todo)
     await todoBox.put(todo.id, todo);

    return Result.completed(todo.id);
  }
}
