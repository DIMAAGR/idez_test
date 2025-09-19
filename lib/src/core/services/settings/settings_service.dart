import 'package:mobx/mobx.dart';

import '../../../modules/shared/data/models/settings_model.dart';
import '../../../modules/shared/domain/entities/settings_entity.dart';
import '../../../modules/shared/domain/enums/selected_theme_enum.dart';
import '../../../modules/shared/domain/usecases/get_settings_data_use_case.dart';
import '../../contracts/settings_contracts.dart';
import '../../errors/failure.dart';
import '../../state/view_model_state.dart';

part 'settings_service.g.dart';

/// [SettingsService]
///
/// A read-only reactive service that exposes user preferences across the app.
///
/// - Provides a **single source of truth** for settings like theme, notifications,
///   password protection, and recent list size.
/// - Consumers (UI and other modules) only **observe** values; they cannot mutate them directly.
/// - Backed by a MobX store, enabling reactive updates when preferences change.
/// - Data is hydrated from persistent storage via [loadSettings].
/// - Designed for maintainability, testability, and scalability by separating read access
///   (this service) from write access (e.g., use cases or a dedicated SettingsWriter).
class SettingsService = _SettingsServiceBase with _$SettingsService;

abstract class _SettingsServiceBase with Store implements SettingsReader, SettingsMutator {
  final GetSettingsDataUseCase _getSettingsDataUseCase;

  _SettingsServiceBase(this._getSettingsDataUseCase);

  /// Holds the current state of the settings load process.
  /// Can be [InitialState], [LoadingState], [SuccessState] with [SettingsEntity], or [ErrorState].
  @observable
  ViewModelState<Failure, SettingsEntity> _state = InitialState();

  /// Cached success entity when state is [SuccessState].
  /// Returns `null` if not loaded or failed.
  @computed
  SettingsEntity get settingsData => _state is SuccessState<Failure, SettingsEntity>
      ? (_state as SuccessState<Failure, SettingsEntity>).success
      : SettingsModel.defaultSettings().toEntity();

  // ---- Public read-only accessors ----

  /// Current theme preference (light/dark/system).
  @override
  @computed
  SelectedTheme get themeMode => settingsData.selectedTheme;

  /// Whether password protection is enabled.
  @override
  @computed
  bool get isSecurePasswordEnabled => settingsData.isPasswordEnabled;

  /// Whether notifications are enabled.
  @override
  @computed
  bool get isNotificationsEnabled => settingsData.isNotificationEnabled;

  /// Configured size of the "recent tasks" list.
  @override
  @computed
  int get recentListSize => settingsData.listSize;

  /// Current error, if state is [ErrorState].
  @computed
  Failure? get error => _state is ErrorState<Failure, SettingsEntity>
      ? (_state as ErrorState<Failure, SettingsEntity>).error
      : null;

  /// Loads user settings from persistent storage.
  ///
  /// - Sets [state] to [LoadingState] while fetching.
  /// - On success, sets [state] to [SuccessState] with [SettingsEntity].
  /// - On failure, sets [state] to [ErrorState].
  ///
  /// Call this once during app startup to hydrate user preferences.
  @action
  Future<void> loadSettings() async {
    _state = LoadingState();
    final result = await _getSettingsDataUseCase();
    _state = result.fold((f) => ErrorState(f), (settings) => SuccessState(settings));
  }

  /// Hydrates the service with new settings data.
  /// Intended to be called by a dedicated settings writer or use case after updates.
  /// Consumers should not call this directly.
  /// @param next The new [SettingsEntity] to apply.
  /// Updates the internal state to [SuccessState] with the new entity.
  /// This triggers reactive updates to all observers.
  @override
  @action
  void hydrate(SettingsEntity next) {
    _state = SuccessState(next);
  }
}
