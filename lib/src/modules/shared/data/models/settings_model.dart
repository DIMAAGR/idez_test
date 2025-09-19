import '../../domain/entities/settings_entity.dart';
import '../../domain/enums/selected_theme_enum.dart';

class SettingsModel {
  final bool isNotificationEnabled;
  final bool isPasswordEnabled;
  final SelectedTheme selectedTheme;
  final int listSize;

  SettingsModel({
    required this.isNotificationEnabled,
    required this.isPasswordEnabled,
    required this.selectedTheme,
    required this.listSize,
  });

  factory SettingsModel.defaultSettings() {
    return SettingsModel(
      isNotificationEnabled: true,
      isPasswordEnabled: false,
      selectedTheme: SelectedTheme.light,
      listSize: 10,
    );
  }

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      isNotificationEnabled: entity.isNotificationEnabled,
      isPasswordEnabled: entity.isPasswordEnabled,
      selectedTheme: entity.selectedTheme,
      listSize: entity.listSize,
    );
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isNotificationEnabled: json['isNotificationEnabled'] as bool? ?? false,
      isPasswordEnabled: json['isPasswordEnabled'] as bool? ?? false,
      selectedTheme: SelectedTheme.fromString(json['selectedTheme'] as String? ?? 'LIGHT'),
      listSize: json['listSize'] as int? ?? 10,
    );
  }

  SettingsEntity toEntity() {
    return SettingsEntity(
      isNotificationEnabled: isNotificationEnabled,
      isPasswordEnabled: isPasswordEnabled,
      listSize: listSize,
      selectedTheme: selectedTheme,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isNotificationEnabled': isNotificationEnabled,
      'isPasswordEnabled': isPasswordEnabled,
      'selectedTheme': selectedTheme.value.toString(),
      'listSize': listSize,
    };
  }
}
