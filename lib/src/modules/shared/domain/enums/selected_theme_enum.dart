enum SelectedTheme {
  light('LIGHT'),
  dark('DARK'),
  system('SYSTEM');

  final String value;
  const SelectedTheme(this.value);

  static SelectedTheme fromString(String value) {
    return SelectedTheme.values.firstWhere(
      (e) => e.value.toUpperCase() == value.toUpperCase(),
      orElse: () => SelectedTheme.system,
    );
  }
}
