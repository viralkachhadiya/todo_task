import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/src/features/todo/presentation/screens/update_todo_screen.dart';
import 'package:todo_task/src/features/todo/presentation/viewmodel/todo_view_model.dart';
import 'package:todo_task/src/features/todo/presentation/widgets/todo_item.dart';

const String progressIndicatorKey = "PROGRESS INDICATOR KEY";

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    context.read<TodoViewModel>().getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo Task"),
          centerTitle: true,
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          // ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateTodoScreen()))
                  .then((value) => context.read<TodoViewModel>().getAllTodos());
            },
            child: const Icon(Icons.add)),
        body: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TodoViewModel>(
                builder: (context, viewModel, child) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (viewModel.today.isEmpty)
                            const Card(
                              child: ListTile(
                                title: Text(
                                  'No Result Found!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (viewModel.today.isNotEmpty)
                            ...List.generate(
                                viewModel.today.length,
                                (index) => TodoItem(
                                      todo: viewModel.today[index],
                                    )).toList(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Tomorrow',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (viewModel.tomorrow.isEmpty)
                            const Card(
                              child: ListTile(
                                title: Text(
                                  'No Result Found!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (viewModel.tomorrow.isNotEmpty)
                            ...List.generate(
                                viewModel.tomorrow.length,
                                (index) => TodoItem(
                                      todo: viewModel.tomorrow[index],
                                    )).toList(),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Upcoming',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (viewModel.upcoming.isEmpty)
                            const Card(
                              child: ListTile(
                                title: Text(
                                  'No Result Found!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (viewModel.upcoming.isNotEmpty)
                            ...List.generate(
                                viewModel.upcoming.length,
                                (index) => TodoItem(
                                      todo: viewModel.upcoming[index],
                                    )).toList()
                        ]),
                  );
                },
              ),
            )));
  }
}
