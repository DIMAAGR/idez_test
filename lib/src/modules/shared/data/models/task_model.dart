import 'package:idez_test/src/modules/shared/domain/entities/task_entity.dart';

class TaskModel {
  final String id;
  final String title;
  final bool done;
  final String createdAt;
  final String? dueDate;
  final String? categoryId;

  TaskModel({
    required this.id,
    required this.title,
    required this.done,
    required this.createdAt,
    this.dueDate,
    this.categoryId,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    bool? done,
    String? createdAt,
    String? dueDate,
    String? categoryId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      done: entity.done,
      createdAt: entity.createdAt.toIso8601String(),
      dueDate: entity.dueDate?.toIso8601String(),
      categoryId: entity.categoryId,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      done: json['done'],
      createdAt: json['createdAt'],
      dueDate: json['dueDate'],
      categoryId: json['categoryId'],
    );
  }

  TaskEntity toEntity() => TaskEntity(
    id: id,
    title: title,
    done: done,
    createdAt: DateTime.parse(createdAt),
    dueDate: dueDate != null ? DateTime.parse(dueDate!) : null,
    categoryId: categoryId,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'done': done,
    'createdAt': createdAt,
    'dueDate': dueDate,
    'categoryId': categoryId,
  };
}
