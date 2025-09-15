enum BoardType {
  all('ALL'),
  pending('PENDING'),
  overdue('OVERDUE');

  final String value;
  const BoardType(this.value);

  static BoardType fromString(String value) {
    return BoardType.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => BoardType.all,
    );
  }
}
