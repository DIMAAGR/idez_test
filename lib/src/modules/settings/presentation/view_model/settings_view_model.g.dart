// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on _SettingsViewModelBase, Store {
  late final _$saveStateAtom = Atom(
    name: '_SettingsViewModelBase.saveState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get saveState {
    _$saveStateAtom.reportRead();
    return super.saveState;
  }

  @override
  set saveState(ViewModelState<Failure, void> value) {
    _$saveStateAtom.reportWrite(value, super.saveState, () {
      super.saveState = value;
    });
  }

  late final _$clearStateAtom = Atom(
    name: '_SettingsViewModelBase.clearState',
    context: context,
  );

  @override
  ViewModelState<Failure, void> get clearState {
    _$clearStateAtom.reportRead();
    return super.clearState;
  }

  @override
  set clearState(ViewModelState<Failure, void> value) {
    _$clearStateAtom.reportWrite(value, super.clearState, () {
      super.clearState = value;
    });
  }

  late final _$isNotificationEnabledAtom = Atom(
    name: '_SettingsViewModelBase.isNotificationEnabled',
    context: context,
  );

  @override
  bool get isNotificationEnabled {
    _$isNotificationEnabledAtom.reportRead();
    return super.isNotificationEnabled;
  }

  @override
  set isNotificationEnabled(bool value) {
    _$isNotificationEnabledAtom.reportWrite(
      value,
      super.isNotificationEnabled,
      () {
        super.isNotificationEnabled = value;
      },
    );
  }

  late final _$selectedThemeAtom = Atom(
    name: '_SettingsViewModelBase.selectedTheme',
    context: context,
  );

  @override
  SelectedTheme get selectedTheme {
    _$selectedThemeAtom.reportRead();
    return super.selectedTheme;
  }

  @override
  set selectedTheme(SelectedTheme value) {
    _$selectedThemeAtom.reportWrite(value, super.selectedTheme, () {
      super.selectedTheme = value;
    });
  }

  late final _$isPasswordEnabledAtom = Atom(
    name: '_SettingsViewModelBase.isPasswordEnabled',
    context: context,
  );

  @override
  bool get isPasswordEnabled {
    _$isPasswordEnabledAtom.reportRead();
    return super.isPasswordEnabled;
  }

  @override
  set isPasswordEnabled(bool value) {
    _$isPasswordEnabledAtom.reportWrite(value, super.isPasswordEnabled, () {
      super.isPasswordEnabled = value;
    });
  }

  late final _$recentListSizeAtom = Atom(
    name: '_SettingsViewModelBase.recentListSize',
    context: context,
  );

  @override
  int get recentListSize {
    _$recentListSizeAtom.reportRead();
    return super.recentListSize;
  }

  @override
  set recentListSize(int value) {
    _$recentListSizeAtom.reportWrite(value, super.recentListSize, () {
      super.recentListSize = value;
    });
  }

  late final _$_doToggleAllNotificationsAsyncAction = AsyncAction(
    '_SettingsViewModelBase._doToggleAllNotifications',
    context: context,
  );

  @override
  Future<ViewModelState<Failure, void>> _doToggleAllNotifications(
    bool isEnabled,
  ) {
    return _$_doToggleAllNotificationsAsyncAction.run(
      () => super._doToggleAllNotifications(isEnabled),
    );
  }

  late final _$saveAsyncAction = AsyncAction(
    '_SettingsViewModelBase.save',
    context: context,
  );

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$clearAllDataAsyncAction = AsyncAction(
    '_SettingsViewModelBase.clearAllData',
    context: context,
  );

  @override
  Future<void> clearAllData() {
    return _$clearAllDataAsyncAction.run(() => super.clearAllData());
  }

  late final _$_SettingsViewModelBaseActionController = ActionController(
    name: '_SettingsViewModelBase',
    context: context,
  );

  @override
  void toggleNotification() {
    final _$actionInfo = _$_SettingsViewModelBaseActionController.startAction(
      name: '_SettingsViewModelBase.toggleNotification',
    );
    try {
      return super.toggleNotification();
    } finally {
      _$_SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTheme(SelectedTheme theme) {
    final _$actionInfo = _$_SettingsViewModelBaseActionController.startAction(
      name: '_SettingsViewModelBase.setSelectedTheme',
    );
    try {
      return super.setSelectedTheme(theme);
    } finally {
      _$_SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePassword() {
    final _$actionInfo = _$_SettingsViewModelBaseActionController.startAction(
      name: '_SettingsViewModelBase.togglePassword',
    );
    try {
      return super.togglePassword();
    } finally {
      _$_SettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saveState: ${saveState},
clearState: ${clearState},
isNotificationEnabled: ${isNotificationEnabled},
selectedTheme: ${selectedTheme},
isPasswordEnabled: ${isPasswordEnabled},
recentListSize: ${recentListSize}
    ''';
  }
}
