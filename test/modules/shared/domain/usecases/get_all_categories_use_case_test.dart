import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/entities/category_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_all_categories_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late GetAllCategoriesUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = GetAllCategoriesUseCaseImpl(repo);
  });

  test('sucesso: retorna lista de categorias do repo', () async {
    final expected = [
      CategoryEntity(id: '1', name: 'Work'),
      CategoryEntity(id: '2', name: 'Study'),
    ];

    when(repo.getAllCategories()).thenAnswer((_) async => Right(expected));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('não deveria falhar'), (list) {
      expect(list, expected);
    });

    verify(repo.getAllCategories()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('falha: retorna Left(StorageFailure)', () async {
    final failure = StorageFailure('boom');

    when(repo.getAllCategories()).thenAnswer((_) async => Left(failure));

    final result = await usecase();

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria ter sucesso'));

    verify(repo.getAllCategories()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
