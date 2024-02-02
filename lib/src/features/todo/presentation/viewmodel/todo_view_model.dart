import 'package:flutter/material.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/update_todo_usecase.dart';

class TodoViewModel extends ChangeNotifier {
  final InsertTodoUsecase? insertTodoUsecase;
  final UpdateTodoUsecase? updateTodoUsecase;
  final RemoveTodoUsecase? removeTodoUsecase;
  final GetTodoByIdUsecase? getTodoByIdUsecase;
  final GetAllTodosUsecase? getAllTodosUsecase;

  TodoViewModel(
      {this.insertTodoUsecase,
      this.updateTodoUsecase,
      this.removeTodoUsecase,
      this.getTodoByIdUsecase,
      this.getAllTodosUsecase});

  final List<Todo> today = [];
  final List<Todo> tomorrow = [];
  final List<Todo> upcoming = [];

  Future<void> getAllTodos() async {
    today.clear();
    tomorrow.clear();
    upcoming.clear();
    var data = await getAllTodosUsecase!();
    (data.data as List<Todo>).map((e) {
      if (e.createdAtUtc!.day == DateTime.now().day) {
        today.add(e);
      } else if (e.createdAtUtc!.day == (DateTime.now().day + 1)) {
        tomorrow.add(e);
      } else {
        upcoming.add(e);
      }
    }).toList();
    print("today" + today.length.toString());
    print("tomorrow" + tomorrow.length.toString());
    print("upcoming" + upcoming.length.toString());
    notifyListeners();
  }

  Future<void> insertTodo(Todo todo) async {
    await insertTodoUsecase!(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await updateTodoUsecase!(todo);
  }

  Future<void> removeTodo(Todo todo) async {
    await removeTodoUsecase!(todo);
  }
}
