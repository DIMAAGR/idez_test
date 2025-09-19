// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsService on _SettingsServiceBase, Store {
  Computed<SettingsEntity>? _$settingsDataComputed;

  @override
  SettingsEntity get settingsData =>
      (_$settingsDataComputed ??= Computed<SettingsEntity>(
        () => super.settingsData,
        name: '_SettingsServiceBase.settingsData',
      )).value;
  Computed<SelectedTheme>? _$themeModeComputed;

  @override
  SelectedTheme get themeMode =>
      (_$themeModeComputed ??= Computed<SelectedTheme>(
        () => super.themeMode,
        name: '_SettingsServiceBase.themeMode',
      )).value;
  Computed<bool>? _$isSecurePasswordEnabledComputed;

  @override
  bool get isSecurePasswordEnabled =>
      (_$isSecurePasswordEnabledComputed ??= Computed<bool>(
        () => super.isSecurePasswordEnabled,
        name: '_SettingsServiceBase.isSecurePasswordEnabled',
      )).value;
  Computed<bool>? _$isNotificationsEnabledComputed;

  @override
  bool get isNotificationsEnabled =>
      (_$isNotificationsEnabledComputed ??= Computed<bool>(
        () => super.isNotificationsEnabled,
        name: '_SettingsServiceBase.isNotificationsEnabled',
      )).value;
  Computed<int>? _$recentListSizeComputed;

  @override
  int get recentListSize => (_$recentListSizeComputed ??= Computed<int>(
    () => super.recentListSize,
    name: '_SettingsServiceBase.recentListSize',
  )).value;
  Computed<Failure?>? _$errorComputed;

  @override
  Failure? get error => (_$errorComputed ??= Computed<Failure?>(
    () => super.error,
    name: '_SettingsServiceBase.error',
  )).value;

  late final _$_stateAtom = Atom(
    name: '_SettingsServiceBase._state',
    context: context,
  );

  @override
  ViewModelState<Failure, SettingsEntity> get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(ViewModelState<Failure, SettingsEntity> value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$loadSettingsAsyncAction = AsyncAction(
    '_SettingsServiceBase.loadSettings',
    context: context,
  );

  @override
  Future<void> loadSettings() {
    return _$loadSettingsAsyncAction.run(() => super.loadSettings());
  }

  late final _$_SettingsServiceBaseActionController = ActionController(
    name: '_SettingsServiceBase',
    context: context,
  );

  @override
  void hydrate(SettingsEntity next) {
    final _$actionInfo = _$_SettingsServiceBaseActionController.startAction(
      name: '_SettingsServiceBase.hydrate',
    );
    try {
      return super.hydrate(next);
    } finally {
      _$_SettingsServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
settingsData: ${settingsData},
themeMode: ${themeMode},
isSecurePasswordEnabled: ${isSecurePasswordEnabled},
isNotificationsEnabled: ${isNotificationsEnabled},
recentListSize: ${recentListSize},
error: ${error}
    ''';
  }
}
