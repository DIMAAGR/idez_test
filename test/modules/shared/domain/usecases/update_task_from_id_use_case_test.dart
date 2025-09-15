import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/modules/shared/domain/usecases/update_task_from_id_use_case.dart';
import 'package:idez_test/src/modules/shared/data/models/task_model.dart';
import 'package:idez_test/src/core/errors/failure.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late UpdateTaskFromIdUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = UpdateTaskFromIdUseCaseImpl(repo);
  });

  test('deve chamar updateFromId e retornar Right(null)', () async {
    final model = TaskModel(
      id: '1',
      title: 'Edit',
      done: false,
      createdAt: DateTime(2024).toIso8601String(),
      dueDate: null,
      categoryId: null,
    );

    when(repo.updateFromId(any, any)).thenAnswer((_) async => const Right(null));

    final result = await usecase('1', model);

    expect(result.isRight(), true);
    verify(repo.updateFromId('1', model)).called(1);
  });

  test('retorna Failure se repo falhar', () async {
    when(repo.updateFromId(any, any)).thenAnswer((_) async => Left(StorageFailure('boom')));

    final result = await usecase(
      '1',
      TaskModel(
        id: '1',
        title: 'x',
        done: false,
        createdAt: DateTime.now().toIso8601String(),
        dueDate: null,
        categoryId: null,
      ),
    );

    expect(result.isLeft(), true);
  });
}
