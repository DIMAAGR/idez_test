import 'package:idez_test/src/core/extensions/date_time_extension.dart';
import 'package:mobx/mobx.dart';
import '../../domain/entities/task_entity.dart';
import '../models/pill_tab_enum.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  // ----------------------------
  // Navegação
  // ----------------------------
  @observable
  PillTab currentTab = PillTab.home;

  // ----------------------------
  // Estado das tarefas
  // ----------------------------
  @observable
  ObservableList<TaskEntity> tasks = ObservableList.of([
    TaskEntity(
      id: "1",
      title: "Fazer 30 minutos de exercício",
      done: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      dueDate: DateTime.now().add(const Duration(days: 1)),
      categoryId: "saude",
    ),
    TaskEntity(
      id: "2",
      title: "Estudar Flutter por 1 hora",
      done: false,
      createdAt: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 2)),
      categoryId: "estudo",
    ),
    TaskEntity(
      id: "3",
      title: "Comprar frutas no mercado",
      done: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      dueDate: null,
      categoryId: "compras",
    ),
    TaskEntity(
      id: "4",
      title: "Ler 20 páginas do livro",
      done: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      dueDate: DateTime.now().add(const Duration(days: 3)),
      categoryId: "leitura",
    ),
    TaskEntity(
      id: "5",
      title: "Beber 2 litros de água",
      done: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      dueDate: null,
      categoryId: "saude",
    ),
    TaskEntity(
      id: "6",
      title: "Revisar código do projeto",
      done: false,
      createdAt: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 1)),
      categoryId: "trabalho",
    ),
    TaskEntity(
      id: "7",
      title: "Assistir palestra online",
      done: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      dueDate: DateTime.now().add(const Duration(days: 5)),
      categoryId: "aprendizado",
    ),
    TaskEntity(
      id: "8",
      title: "Ligar para João",
      done: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      dueDate: null,
      categoryId: "pessoal",
    ),
    TaskEntity(
      id: "9",
      title: "Arrumar o quarto",
      done: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      dueDate: DateTime.now().add(const Duration(days: 1)),
      categoryId: "casa",
    ),
    TaskEntity(
      id: "10",
      title: "Preparar apresentação",
      done: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      dueDate: DateTime.now().add(const Duration(days: 4)),
      categoryId: "trabalho",
    ),
  ]);

  // ----------------------------
  // Lista Organizada de Tarefas Concluídas
  // ----------------------------
  @computed
  List<TaskEntity> get doneTasks {
    final list = tasks.where((t) => t.done).toList(growable: false);
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  // ----------------------------
  // Seleção
  // ----------------------------
  @observable
  ObservableSet<String> selectedTasksIDs = ObservableSet<String>();

  @observable
  bool isSelectionMode = false;

  @computed
  int get selectedCount => selectedTasksIDs.length;

  @action
  bool isSelected(String id) => selectedTasksIDs.contains(id);

  @action
  void startSelection(String id) {
    if (!isSelectionMode) isSelectionMode = true;
    selectedTasksIDs.add(id);
  }

  @action
  void toggleSelection(String id) {
    if (!isSelectionMode) return;
    if (!selectedTasksIDs.remove(id)) {
      selectedTasksIDs.add(id);
    }
    if (selectedTasksIDs.isEmpty) {
      isSelectionMode = false;
    }
  }

  @action
  void clearSelection() {
    selectedTasksIDs.clear();
    isSelectionMode = false;
  }

  @action
  void deleteSelectedTasks() {
    tasks.removeWhere((t) => selectedTasksIDs.contains(t.id));
    clearSelection();
  }

  // ----------------------------
  // Ações de tarefa
  // ----------------------------

  @action
  void setDone(String id, bool done) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final old = tasks[idx];
    tasks[idx] = old.copyWith(done: done);
  }

  @action
  void updateTask(String id, {String? title, String? categoryId, DateTime? dueDate}) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final old = tasks[idx];
    tasks[idx] = old.copyWith(
      title: title ?? old.title,
      categoryId: categoryId ?? old.categoryId,
      dueDate: dueDate ?? old.dueDate,
    );
  }

  @action
  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    selectedTasksIDs.remove(id);
    if (selectedTasksIDs.isEmpty) isSelectionMode = false;
  }

  // ----------------------------
  // Contagens para o "HomeOptionsGrid"
  // ----------------------------
  @computed
  int get tasksCount => tasks.length;

  @computed
  int get pendingTasksCount {
    return tasks.where((t) => !t.done && t.dueDate != null && t.dueDate!.isOlderThanNow).length;
  }

  @computed
  int get overdueTasksCount {
    final now = DateTime.now();
    return tasks.where((t) => !t.done && t.dueDate != null && t.dueDate!.isAfter(now)).length;
  }

  @computed
  int get categoriesCount {
    final set = <String>{};
    for (final t in tasks) {
      if (t.categoryId != null && t.categoryId!.isNotEmpty) set.add(t.categoryId!);
    }
    return set.length;
  }
}
