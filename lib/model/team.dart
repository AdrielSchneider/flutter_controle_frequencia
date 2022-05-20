class Team {
  static const table = 'team';

  static const columnId = 'id';
  int? id;

  static const columnDescription = 'description';
  String description;

  static const columnPeriod = 'period';
  String period;

  Team({this.id, required this.description, required this.period});

  factory Team.fromMap(Map map) {
    return Team(
        id: map[columnId] ?? 0,
        description: map[columnDescription],
        period: map[columnPeriod],);
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnDescription: description,
      columnPeriod: period,
    };
  }
}
