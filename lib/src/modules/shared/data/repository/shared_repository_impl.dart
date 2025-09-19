import 'package:dartz/dartz.dart';
import 'package:idez_test/src/modules/shared/domain/entities/settings_entity.dart';
import 'package:idez_test/src/modules/shared/domain/repository/shared_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/data_source/task_local_data_source.dart';
import '../../../shared/domain/entities/category_entity.dart';
import '../../../shared/domain/entities/task_entity.dart';
import '../models/task_model.dart';

class SharedRepositoryImpl implements SharedRepository {
  final TasksLocalDataSource local;

  SharedRepositoryImpl(this.local);

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final models = await local.getAllTasks();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e, s) {
      return Left(StorageFailure('Failed to load tasks', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final models = await local.getAllCategories();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e, s) {
      return Left(StorageFailure('Failed to load categories', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromId(String id) async {
    try {
      final list = await local.getAllTasks();
      final filtered = list.where((t) => t.id != id).toList();
      await local.saveAllTasks(filtered);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to delete task', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromIdRange(Iterable<String> ids) async {
    try {
      final set = ids.toSet();
      final list = await local.getAllTasks();
      final filtered = list.where((t) => !set.contains(t.id)).toList();
      await local.saveAllTasks(filtered);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to delete tasks', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllDoneTasks() async {
    try {
      final models = await local.getAllTasks();
      final doneTasks = models.where((m) => m.done).toList();
      return Right(doneTasks.map((m) => m.toEntity()).toList());
    } catch (e, s) {
      return Left(StorageFailure('Failed to load done tasks', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> updateFromId(id, TaskEntity task) async {
    try {
      final list = await local.getAllTasks();
      final idx = list.indexWhere((t) => t.id == id);
      if (idx == -1) return Left(NotFoundFailure('Task not found'));
      list[idx] = TaskModel.fromEntity(task);
      await local.saveAllTasks(list);
      return Right(null);
    } catch (e, s) {
      return Left(StorageFailure('Failed to edit task', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, SettingsEntity>> getSettingsData() async {
    try {
      final settings = await local.getSettingsData();
      return Right(settings.toEntity());
    } catch (e, s) {
      return Left(StorageFailure('Failed to load settings', cause: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, bool>> getNotificationEnabled() async {
    try {
      final settings = await local.getSettingsData();
      return Right(settings.isNotificationEnabled);
    } catch (e, s) {
      return Left(StorageFailure('Failed to load notification setting', cause: e, stackTrace: s));
    }
  }
}
