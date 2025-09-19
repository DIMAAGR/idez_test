import 'package:idez_test/src/core/services/settings/settings_service.dart';
import 'package:idez_test/src/core/state/view_model_state.dart';
import 'package:idez_test/src/modules/settings/domain/usecases/clear_all_data_use_case.dart';
import 'package:idez_test/src/modules/settings/domain/usecases/post_save_settings_use_cse.dart';
import 'package:idez_test/src/modules/shared/domain/entities/settings_entity.dart';
import 'package:idez_test/src/modules/shared/domain/enums/selected_theme_enum.dart';
import 'package:idez_test/src/modules/settings/domain/usecases/toggle_task_reminders_use_case.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/errors/failure.dart';
import '../../../shared/data/models/settings_model.dart';

part 'settings_view_model.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase with Store {
  final SettingsService _service;
  final PostSaveSettingsUseCase _saveSettings;
  final ClearAllDataUseCase _clearAllData;
  final ToggleAllNotificationsUseCase _toggleAllNotifications;

  _SettingsViewModelBase(
    this._service,
    this._saveSettings,
    this._clearAllData,
    this._toggleAllNotifications,
  ) {
    isNotificationEnabled = _service.settingsData.isNotificationEnabled;
    isPasswordEnabled = _service.isSecurePasswordEnabled;
    selectedTheme = _service.themeMode;
    recentListSize = _service.recentListSize;
  }

  @observable
  ViewModelState<Failure, void> saveState = InitialState();

  @observable
  ViewModelState<Failure, void> clearState = InitialState();

  @observable
  bool isNotificationEnabled = false;

  @observable
  SelectedTheme selectedTheme = SelectedTheme.light;

  @observable
  bool isPasswordEnabled = false;

  @observable
  int recentListSize = 10;

  @action
  void toggleNotification() => isNotificationEnabled = !isNotificationEnabled;

  @action
  void setSelectedTheme(SelectedTheme theme) => selectedTheme = theme;

  @action
  void togglePassword() => isPasswordEnabled = !isPasswordEnabled;

  @action
  Future<ViewModelState<Failure, void>> _doToggleAllNotifications(bool isEnabled) async {
    final result = await _toggleAllNotifications(isEnabled);
    return result.fold((failure) async => ErrorState(failure), (_) async => SuccessState(null));
  }

  @action
  Future<void> save() async {
    saveState = LoadingState();

    final SettingsEntity next = _service.settingsData.copyWith(
      isNotificationEnabled: isNotificationEnabled,
      isPasswordEnabled: isPasswordEnabled,
      selectedTheme: selectedTheme,
      listSize: recentListSize,
    );

    final result = await _saveSettings(SettingsModel.fromEntity(next));

    saveState = await result.fold((failure) async => ErrorState(failure), (_) async {
      if (isNotificationEnabled != _service.settingsData.isNotificationEnabled) {
        _service.hydrate(next);
        return await _doToggleAllNotifications(isNotificationEnabled);
      }

      _service.hydrate(next);
      return SuccessState(null);
    });
  }

  @action
  Future<void> clearAllData() async {
    clearState = LoadingState();

    final result = await _doToggleAllNotifications(false);

    if (result is ErrorState) {
      clearState = result;
      return;
    } else if (result is SuccessState) {
      final res = await _clearAllData();
      clearState = await res.fold((f) async => ErrorState(f), (_) async {
        return SuccessState(null);
      });
    }
  }
}
