import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/src/features/todo/data/models/todo_model.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/presentation/screens/update_todo_screen.dart';
import 'package:todo_task/src/features/todo/presentation/viewmodel/todo_view_model.dart';

class TodoItem extends StatelessWidget {
  final Todo? todo;
  const TodoItem({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    todo!.title!,
                    style: const TextStyle(
                        fontSize: 18, height: 1, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo!.description!,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy").format(todo!.createdAtUtc!),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTodoScreen(
                                todo: todo,
                              ))).then(
                      (value) => context.read<TodoViewModel>().getAllTodos());
                }),
            IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.red,
                ),
                onPressed: () {
                  context
                      .read<TodoViewModel>()
                      .removeTodo(TodoModel(
                          id: todo!.id,
                          title: todo!.title,
                          description: todo!.description,
                          createdAtUtc: todo!.createdAtUtc))
                      .then((value) =>
                          context.read<TodoViewModel>().getAllTodos());
                })
          ],
        ),
      ),
    );
  }
}
