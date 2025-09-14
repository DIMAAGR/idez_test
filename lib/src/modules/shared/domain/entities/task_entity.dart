class TaskEntity {
  final String id;
  final String title;
  final bool done;
  final DateTime createdAt;
  final DateTime? dueDate;
  final String? categoryId;

  const TaskEntity({
    required this.id,
    required this.title,
    this.done = false,
    required this.createdAt,
    this.dueDate,
    this.categoryId,
  });

  TaskEntity copyWith({String? title, bool? done, DateTime? dueDate, String? categoryId}) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
