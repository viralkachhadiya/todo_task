import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/src/features/todo/presentation/screens/todo_screen.dart';
import 'package:todo_task/src/features/todo/presentation/viewmodel/todo_view_model.dart';
import 'package:todo_task/src/sertup_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<TodoViewModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TodosScreen(),
      ),
    );
  }
}
