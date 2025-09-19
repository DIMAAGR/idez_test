import '../enums/selected_theme_enum.dart';

class SettingsEntity {
  final bool isNotificationEnabled;
  final bool isPasswordEnabled;
  final int listSize;
  final SelectedTheme selectedTheme;

  SettingsEntity({
    required this.isNotificationEnabled,
    required this.isPasswordEnabled,
    required this.listSize,
    required this.selectedTheme,
  });

  SettingsEntity copyWith({
    bool? isNotificationEnabled,
    bool? isPasswordEnabled,
    int? listSize,
    SelectedTheme? selectedTheme,
  }) {
    return SettingsEntity(
      isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
      isPasswordEnabled: isPasswordEnabled ?? this.isPasswordEnabled,
      listSize: listSize ?? this.listSize,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }

  @override
  String toString() {
    return 'SettingsEntity(isNotificationEnabled: $isNotificationEnabled, isPasswordEnabled: $isPasswordEnabled, listSize: $listSize, selectedTheme: $selectedTheme)';
  }
}
