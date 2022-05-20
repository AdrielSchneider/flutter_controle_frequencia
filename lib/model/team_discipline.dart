class TeamDiscipline {
  static const table = 'teamDiscipline';

  static const columnIdDiscipline = 'idDiscipline';
  int idDiscipline;

  static const columnIdTeam = 'idTeam';
  int idTeam;

  TeamDiscipline({required this.idDiscipline, required this.idTeam});

  factory TeamDiscipline.fromMap(Map map) {
    return TeamDiscipline(
      idDiscipline: map[columnIdDiscipline],
      idTeam: map[columnIdTeam],);
  }

  Map<String, dynamic> toMap() {
    return {
      columnIdDiscipline: idDiscipline,
      columnIdTeam: idTeam,
    };
  }
}