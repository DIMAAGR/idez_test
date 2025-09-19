import '../../modules/shared/domain/entities/settings_entity.dart';
import '../../modules/shared/domain/enums/selected_theme_enum.dart';

abstract class SettingsReader {
  SelectedTheme get themeMode;
  bool get isNotificationsEnabled;
  bool get isSecurePasswordEnabled;
  int get recentListSize;
}

abstract class SettingsMutator {
  void hydrate(SettingsEntity next);
}
