import 'package:flutter_test/flutter_test.dart';
import 'package:idez_test/src/modules/shared/domain/enums/selected_theme_enum.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:idez_test/src/core/errors/failure.dart';
import 'package:idez_test/src/modules/shared/domain/entities/settings_entity.dart';
import 'package:idez_test/src/modules/shared/domain/usecases/get_settings_data_use_case.dart';

import '../../../../mocks/mocks.mocks.mocks.dart';

void main() {
  late MockSharedRepository repo;
  late GetSettingsDataUseCase usecase;

  setUp(() {
    repo = MockSharedRepository();
    usecase = GetSettingsDataUseCaseImpl(repo);
  });

  test('sucesso: retorna SettingsEntity do repo', () async {
    final expected = SettingsEntity(
      isNotificationEnabled: true,
      isPasswordEnabled: false,
      listSize: 10,
      selectedTheme: SelectedTheme.system,
    );

    when(repo.getSettingsData()).thenAnswer((_) async => Right(expected));

    final result = await usecase();

    expect(result.isRight(), true);
    result.fold((_) => fail('não deveria falhar'), (settings) {
      expect(settings.isNotificationEnabled, true);
      expect(settings.selectedTheme, SelectedTheme.system);
    });

    verify(repo.getSettingsData()).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('falha: retorna Left(StorageFailure)', () async {
    final failure = StorageFailure('erro ao carregar settings');

    when(repo.getSettingsData()).thenAnswer((_) async => Left(failure));

    final result = await usecase();

    expect(result.isLeft(), true);
    result.fold((l) => expect(l, failure), (_) => fail('não deveria ter sucesso'));

    verify(repo.getSettingsData()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
