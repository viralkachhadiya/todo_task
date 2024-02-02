import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_task/src/features/todo/data/data_sources/local_data_source.dart';
import 'package:todo_task/src/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_task/src/features/todo/domain/entities/todo.dart';
import 'package:todo_task/src/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_task/src/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_task/src/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:todo_task/src/features/todo/presentation/viewmodel/todo_view_model.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

final sl = GetIt.instance;
Future<void> setup() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;
    hive.init(directory.path);
    hive.registerAdapter<Todo>(TodoAdapter());
    return hive;
  });

  //Change notifier
  sl.registerFactory(() => TodoViewModel(
      getTodoByIdUsecase: sl(),
      removeTodoUsecase: sl(),
      insertTodoUsecase: sl(),
      updateTodoUsecase: sl(),
      getAllTodosUsecase: sl()));

  // Data sources
  sl.registerLazySingleton<ILocalDataSource>(() => LocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetTodoByIdUsecase(sl()));
  sl.registerLazySingleton(() => RemoveTodoUsecase(sl()));
  sl.registerLazySingleton(() => InsertTodoUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTodoUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTodosUsecase(sl()));
}
