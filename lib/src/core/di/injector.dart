import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:idez_test/src/core/storage/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/board/presentation/view_model/board_view_model.dart';
import '../../modules/categories/data/repository/categories_repository_impl.dart';
import '../../modules/categories/domain/repository/categories_repository.dart';
import '../../modules/categories/domain/usecases/create_category_use_case.dart';
import '../../modules/categories/domain/usecases/delete_category_from_id_range_use_case.dart';
import '../../modules/categories/domain/usecases/delete_category_from_id_use_case.dart';
import '../../modules/categories/domain/usecases/update_category_from_id_use_case.dart';
import '../../modules/categories/presentation/view_model/categories_view_model.dart';
import '../../modules/home/presentation/view_model/home_view_model.dart';
import '../../modules/settings/data/datasource/settings_local_data_source_impl.dart';
import '../../modules/settings/data/repository/settings_repository_impl.dart';
import '../../modules/settings/domain/datasource/settings_local_data_source.dart';
import '../../modules/settings/domain/repository/settings_repository.dart';
import '../../modules/settings/domain/usecases/clear_all_data_use_case.dart';
import '../../modules/settings/domain/usecases/post_save_settings_use_cse.dart';
import '../../modules/settings/presentation/view_model/settings_view_model.dart';
import '../../modules/shared/data/data_source/task_local_data_source.dart';
import '../../modules/shared/data/data_source/task_local_data_source_impl.dart';
import '../../modules/shared/data/repository/shared_repository_impl.dart';
import '../../modules/shared/domain/gateways/notification_gateway.dart';
import '../../modules/shared/domain/repository/shared_repository.dart';
import '../../modules/shared/domain/services/reminder_policy.dart';
import '../../modules/shared/domain/usecases/cancel_task_reminders_use_case.dart';
import '../../modules/shared/domain/usecases/delete_from_id_range_use_case.dart';
import '../../modules/shared/domain/usecases/delete_from_id_use_case.dart';
import '../../modules/shared/domain/usecases/get_all_categories_use_case.dart';
import '../../modules/shared/domain/usecases/get_all_done_tasks_use_case.dart';
import '../../modules/shared/domain/usecases/get_all_tasks_use_case.dart';
import '../../modules/shared/domain/usecases/get_notification_enabled_use_case.dart';
import '../../modules/shared/domain/usecases/get_settings_data_use_case.dart';
import '../../modules/shared/domain/usecases/schedule_task_reminders_use_case.dart';
import '../../modules/settings/domain/usecases/toggle_task_reminders_use_case.dart';
import '../../modules/shared/domain/usecases/update_task_from_id_use_case.dart';
import '../../modules/shared/infra/flutter_local_notifications_gateway.dart';
import '../../modules/task/data/repository/task_repository_impl.dart';
import '../../modules/task/domain/repository/task_repository.dart';
import '../../modules/task/domain/usecases/create_task_use_case.dart';
import '../../modules/task/presentation/view_model/task_view_model.dart';
import '../services/settings/settings_service.dart';

void setupInjector() {
  final GetIt getIt = GetIt.instance;

  ///
  /// INFRA
  ///
  getIt.registerLazySingleton<KeyValueStore>(() => SharedPrefsStore(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<TasksLocalDataSource>(() => TasksLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<SettingsLocalDataSource>(() => SettingsLocalDataSourceImpl(getIt()));
  getIt.registerLazySingleton<TasksRepository>(() => TaskRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SharedRepository>(() => SharedRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(getIt()));
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<NotificationGateway>(() => FlutterLocalNotificationsGateway(getIt()));

  getIt.registerFactory<ReminderPolicy>(
    () => ReminderPolicy(
      getIt<CancelTaskRemindersUseCase>(),
      getIt<ScheduleTaskRemindersUseCase>(),
      getIt<GetNotificationEnabledUseCase>(),
    ),
  );

  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  ///
  /// SERVICES
  ///
  getIt.registerLazySingleton<SettingsService>((() => SettingsService(getIt())));

  ///
  /// Home View Model
  ///
  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  ///
  /// Task View Model
  ///
  getIt.registerFactory<TaskViewModel>(() => TaskViewModel(getIt(), getIt(), getIt()));

  ///
  /// Board View Model
  ///
  getIt.registerFactory<BoardViewModel>(
    () => BoardViewModel(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  ///
  /// Categories View Model
  ///
  getIt.registerFactory<CategoriesViewModel>(
    () => CategoriesViewModel(getIt(), getIt(), getIt(), getIt(), getIt()),
  );

  ///
  /// Categories View Model
  ///
  getIt.registerFactory<SettingsViewModel>(
    () => SettingsViewModel(getIt(), getIt(), getIt(), getIt()),
  );

  ///
  /// Use Cases
  ///
  getIt.registerFactory<DeleteFromIdRangeUseCase>(
    () => DeleteFromIdRangeUseCaseImpl(getIt(), getIt()),
  );
  getIt.registerFactory<DeleteFromIdUseCase>(() => DeleteFromIdUseCaseImpl(getIt(), getIt()));
  getIt.registerFactory<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCaseImpl(getIt()));
  getIt.registerFactory<GetAllDoneTasksUseCase>(() => GetAllDoneTasksUseCaseImpl(getIt()));
  getIt.registerFactory<GetAllTasksUseCase>(() => GetAllTasksUseCaseImpl(getIt()));
  getIt.registerFactory<CreateTaskUseCase>(() => CreateTaskUseCaseImpl(getIt(), getIt()));
  getIt.registerFactory<CreateCategoryUseCase>(() => CreateCategoryUseCaseImpl(getIt()));
  getIt.registerFactory<GetSettingsDataUseCase>(() => GetSettingsDataUseCaseImpl(getIt()));
  getIt.registerFactory<PostSaveSettingsUseCase>(() => PostSaveSettingsUseCaseImpl(getIt()));
  getIt.registerFactory<ClearAllDataUseCase>(() => ClearAllDataUseCaseImpl(getIt()));
  getIt.registerFactory<CancelTaskRemindersUseCase>(() => CancelTaskRemindersUseCaseImpl(getIt()));

  getIt.registerFactory<GetNotificationEnabledUseCase>(
    () => GetNotificationEnabledUseCaseImpl(getIt()),
  );
  getIt.registerFactory<ToggleAllNotificationsUseCase>(
    () => ToggleAllNotificationsUseCaseImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<UpdateTaskFromIdUseCase>(
    () => UpdateTaskFromIdUseCaseImpl(getIt(), getIt()),
  );
  getIt.registerFactory<ScheduleTaskRemindersUseCase>(
    () => ScheduleTaskRemindersUseCaseImpl(getIt()),
  );
  getIt.registerFactory<DeleteCategoryFromIdRangeUseCase>(
    () => DeleteCategoryFromIdRangeUseCaseImpl(getIt()),
  );
  getIt.registerFactory<DeleteCategoryFromIdUseCase>(
    () => DeleteCategoryFromIdUseCaseImpl(getIt()),
  );
  getIt.registerFactory<UpdateCategoryFromIdUseCase>(
    () => UpdateCategoryFromIdUseCaseImpl(getIt()),
  );
}
