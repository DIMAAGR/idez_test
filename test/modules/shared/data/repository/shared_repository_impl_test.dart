import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/data/repository/shared_repository_impl.dart';

import '../../../../helpers/fakes.dart';
import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockTasksLocalDataSource local;
  late SharedRepositoryImpl repo;

  setUp(() {
    local = MockTasksLocalDataSource();
    repo = SharedRepositoryImpl(local);
  });

  group('getAllTasks', () {
    test('sucesso -> map para entities', () async {
      when(local.getAllTasks()).thenAnswer((_) async => [tModel('1'), tModel('2', done: true)]);

      final result = await repo.getAllTasks();

      expect(result.isRight(), true);
      result.fold((_) => fail('deveria sucesso'), (list) {
        expect(list.length, 2);
        expect(list.first.id, '1');
        expect(list.last.done, true);
      });
    });

    test('erro -> retorna StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('disk error'));

      final result = await repo.getAllTasks();

      expect(result.isLeft(), true);
      result.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });

  group('deleteFromId', () {
    test('remove 1 id e salva lista', () async {
      final a = tModel('1');
      final b = tModel('2');
      when(local.getAllTasks()).thenAnswer((_) async => [a, b]);
      when(local.saveAllTasks(any)).thenAnswer((_) async => {});

      final res = await repo.deleteFromId('1');

      expect(res.isRight(), true);
      verify(local.saveAllTasks([b])).called(1);
    });
  });

  group('deleteFromIdRange', () {
    test('remove ids e salva', () async {
      final list = [tModel('1'), tModel('2'), tModel('3')];
      when(local.getAllTasks()).thenAnswer((_) async => list);
      when(local.saveAllTasks(any)).thenAnswer((_) async => {});

      final res = await repo.deleteFromIdRange(['1', '3']);

      expect(res.isRight(), true);
      verify(local.saveAllTasks(argThat(hasLength(1)))).called(1);
    });
  });

  group('getAllDoneTasks', () {
    test('filtra done == true', () async {
      when(local.getAllTasks()).thenAnswer((_) async => [tModel('1'), tModel('2', done: true)]);

      final res = await repo.getAllDoneTasks();

      expect(res.isRight(), true);
      res.fold((_) => fail(''), (list) {
        expect(list, hasLength(1));
        expect(list.first.id, '2');
      });
    });
  });

  group('updateFromId', () {
    test('atualiza item existente e salva', () async {
      final list = [tModel('1'), tModel('2')];
      when(local.getAllTasks()).thenAnswer((_) async => list);
      when(local.saveAllTasks(any)).thenAnswer((_) async => {});

      var edited = tModel('2').copyWith(title: 'edited');
      final res = await repo.updateFromId('2', edited);

      expect(res.isRight(), true);
      verify(local.saveAllTasks(argThat(contains(edited)))).called(1);
    });

    test('not found -> NotFoundFailure', () async {
      when(local.getAllTasks()).thenAnswer((_) async => [tModel('1')]);

      final res = await repo.updateFromId('9', tModel('9'));

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<NotFoundFailure>()), (_) => fail('não deveria'));
    });

    test('erro inesperado -> StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('io'));

      final res = await repo.updateFromId('1', tModel('1'));

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });
}
