import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/src/features/todo/data/models/todo_model.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/presentation/viewmodel/todo_view_model.dart';
import 'package:uuid/uuid.dart';

const String addButtonKey = "ADD BUTTON KEY";
const String titleTextFieldKey = "TITLE TEXT FIELD KEY";
const String contentTextFieldKey = "CONTENT TEXT FIELD KEY";

class UpdateTodoScreen extends StatefulWidget {
  const UpdateTodoScreen({Key? key, this.todo}) : super(key: key);
  final Todo? todo;
  @override
  _UpdateTodoScreenState createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  @override
  void initState() {
    if (widget.todo != null) {
      titleController.text = widget.todo!.title!;
      descriptionController.text = widget.todo!.description!;
      dateTimeController.text = DateFormat("dd/MM/yyyy")
          .format(widget.todo!.createdAtUtc!)
          .toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void datePick() {
    final firstDate = DateTime.now();
    final lastDate = firstDate.add(const Duration(days: 365 * 200));

    showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((value) {
      if (value != null) {
        dateTimeController.text =
            DateFormat("dd/MM/yyyy").format(value).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var viewModel = context.read<TodoViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo != null
            ? "Update Todo"
            : "Add Todo"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                key: const Key(titleTextFieldKey),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                key: const Key(contentTextFieldKey),
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: TextField(
                key: const Key(contentTextFieldKey),
                controller: dateTimeController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: "Date",
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  datePick();
                },
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              key: const Key(addButtonKey),
              onPressed: () async {
                if (widget.todo != null) {
                  print("update fun...");
                  TodoModel todo = TodoModel(
                      id: widget.todo!.id!,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      createdAtUtc: DateFormat("dd/MM/yyyy")
                          .parse(dateTimeController.text.trim()));
                  viewModel
                      .updateTodo(todo)
                      .then((value) => Navigator.pop(context));
                } else {
                  TodoModel todo = TodoModel(
                      id: Uuid().v4(),
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      createdAtUtc: DateFormat("dd/MM/yyyy")
                          .parse(dateTimeController.text.trim()));
                  viewModel
                      .insertTodo(todo)
                      .then((value) => Navigator.pop(context));
                }
              },
              child: Container(
                color: Colors.blue,
                height: 50,
                child: Center(
                    child: Text(
                  widget.todo != null
                      ? "Update"
                      : "Add",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
