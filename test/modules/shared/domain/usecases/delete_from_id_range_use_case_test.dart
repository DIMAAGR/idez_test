import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/delete_from_id_range_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late DeleteFromIdRangeUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = DeleteFromIdRangeUseCaseImpl(repo);
  });

  test('deve delegar para o repository e retornar Right(null) no sucesso', () async {
    when(repo.deleteFromIdRange(any)).thenAnswer((_) async => const Right(null));

    final ids = ['1', '2', '3'];
    final result = await usecase(ids);

    expect(result.isRight(), true);
    verify(repo.deleteFromIdRange(ids)).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('deve retornar Left(StorageFailure) no erro', () async {
    final failure = StorageFailure('boom');
    when(repo.deleteFromIdRange(any)).thenAnswer((_) async => Left(failure));

    final result = await usecase(['x']);

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria ter sucesso'));
  });
}
