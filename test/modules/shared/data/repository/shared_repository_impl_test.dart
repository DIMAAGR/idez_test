import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/data/repository/shared_repository_impl.dart';
import 'package:idez_test/src/modules/shared/data/models/task_model.dart';

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

    test('erro inesperado -> StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('io'));

      final res = await repo.deleteFromId('1');

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });

  group('deleteFromIdRange', () {
    test('remove ids e salva', () async {
      final list = [tModel('1'), tModel('2'), tModel('3')];
      when(local.getAllTasks()).thenAnswer((_) async => list);
      when(local.saveAllTasks(any)).thenAnswer((_) async => {});

      final res = await repo.deleteFromIdRange(['1', '3']);

      expect(res.isRight(), true);

      // capture a ÚNICA chamada e faça todas as asserções nela
      final captured = verify(local.saveAllTasks(captureAny)).captured.single as List<TaskModel>;
      expect(captured, hasLength(1));
      expect(captured.single.id, '2');
    });

    test('erro inesperado -> StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('io'));

      final res = await repo.deleteFromIdRange(['1', '2']);

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
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

    test('erro inesperado -> StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('io'));

      final res = await repo.getAllDoneTasks();

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });

  group('updateFromId', () {
    test('atualiza item existente e salva (input é TaskEntity)', () async {
      final list = [tModel('1'), tModel('2')];
      when(local.getAllTasks()).thenAnswer((_) async => list);
      when(local.saveAllTasks(any)).thenAnswer((_) async => {});

      final editedEntity = tModel('2').toEntity().copyWith(title: 'edited');

      final res = await repo.updateFromId('2', editedEntity);

      expect(res.isRight(), true);

      final captured = verify(local.saveAllTasks(captureAny)).captured.last as List<TaskModel>;
      final updated = captured.firstWhere((m) => m.id == '2');
      expect(updated.title, 'edited');
    });

    test('not found -> NotFoundFailure', () async {
      when(local.getAllTasks()).thenAnswer((_) async => [tModel('1')]);

      final res = await repo.updateFromId('9', tModel('9').toEntity());

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<NotFoundFailure>()), (_) => fail('não deveria'));
    });

    test('erro inesperado -> StorageFailure', () async {
      when(local.getAllTasks()).thenThrow(Exception('io'));

      final res = await repo.updateFromId('1', tModel('1').toEntity());

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });

  group('getSettingsData / getNotificationEnabled', () {
    test('getSettingsData sucesso', () async {
      when(local.getSettingsData()).thenAnswer((_) async => tSettingsModel());

      final res = await repo.getSettingsData();

      expect(res.isRight(), true);
      res.fold((_) => fail('não deveria'), (settings) {
        expect(settings.runtimeType.toString(), contains('SettingsEntity'));
      });
    });

    test('getSettingsData falha -> StorageFailure', () async {
      when(local.getSettingsData()).thenThrow(Exception('io'));

      final res = await repo.getSettingsData();

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });

    test('getNotificationEnabled sucesso', () async {
      when(
        local.getSettingsData(),
      ).thenAnswer((_) async => tSettingsModel(isNotificationEnabled: true));

      final res = await repo.getNotificationEnabled();

      expect(res.isRight(), true);
      res.fold((_) => fail('não deveria'), (enabled) => expect(enabled, true));
    });

    test('getNotificationEnabled falha -> StorageFailure', () async {
      when(local.getSettingsData()).thenThrow(Exception('io'));

      final res = await repo.getNotificationEnabled();

      expect(res.isLeft(), true);
      res.fold((l) => expect(l, isA<StorageFailure>()), (_) => fail('não deveria'));
    });
  });
}
