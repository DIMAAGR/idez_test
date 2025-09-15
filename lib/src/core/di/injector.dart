import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/storage/wrapper.dart';
import 'package:idez_test/src/modules/board/presentation/view_model/board_view_model.dart';
import 'package:idez_test/src/modules/shared/data/data_source/task_local_data_source.dart';
import 'package:idez_test/src/modules/shared/data/data_source/task_local_data_source_impl.dart';
import 'package:idez_test/src/modules/shared/domain/repository/shared_repository.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/delete_from_id_range_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/delete_from_id_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_categories_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_done_tasks_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_tasks_use_case.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/update_task_from_id_use_case.dart';
import 'package:idez_test/src/modules/task/data/repository/task_repository_impl.dart';
import 'package:idez_test/src/modules/task/domain/usecases/create_task_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/home/presentation/view_model/home_view_model.dart';
import '../../modules/shared/data/repository/shared_repository_impl.dart';
import '../../modules/task/domain/repository/task_repository.dart';
import '../../modules/task/presentation/view_model/task_view_model.dart';

void setupInjector() {
  final GetIt getIt = GetIt.instance;

  ///
  /// INFRA
  ///);
  getIt.registerLazySingleton<KeyValueStore>(() => SharedPrefsStore(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TasksLocalDataSource>(() => TasksLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<TasksRepository>(() => TaskRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SharedRepository>(() => SharedRepositoryImpl(getIt()));

  ///
  /// Home View Model
  ///
  getIt.registerFactory<HomeViewModel>(
    () => HomeViewModel(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  ///
  /// Task View Model
  ///
  getIt.registerFactory<TaskViewModel>(() => TaskViewModel(getIt(), getIt()));

  ///
  /// Board View Model
  ///
  getIt.registerFactory<BoardViewModel>(() => BoardViewModel(getIt(), getIt(), getIt(), getIt()));

  ///
  /// Use Cases
  ///
  getIt.registerFactory<DeleteFromIdRangeUseCase>(() => DeleteFromIdRangeUseCaseImpl(getIt()));
  getIt.registerFactory<DeleteFromIdUseCase>(() => DeleteFromIdUseCaseImpl(getIt()));
  getIt.registerFactory<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCaseImpl(getIt()));
  getIt.registerFactory<GetAllDoneTasksUseCase>(() => GetAllDoneTasksUseCaseImpl(getIt()));
  getIt.registerFactory<GetAllTasksUseCase>(() => GetAllTasksUseCaseImpl(getIt()));
  getIt.registerFactory<UpdateTaskFromIdUseCase>(() => UpdateTaskFromIdUseCaseImpl(getIt()));
  getIt.registerFactory<CreateTaskUseCase>(() => CreateTaskUseCaseImpl(getIt()));
}
