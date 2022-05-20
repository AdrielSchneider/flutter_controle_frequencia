class Discipline {
  static const table = 'discipline';

  static const columnId = 'id';
  int? id;

  static const columnDescription = 'description';
  String description;

  static const columnIdTeacher = 'idTeacher';
  int idTeacher;

  Discipline({this.id, required this.description, required this.idTeacher});

  factory Discipline.fromMap(Map map) {
    return Discipline(
      id: map[columnId] ?? 0,
      description: map[columnDescription],
      idTeacher: map[columnIdTeacher],);
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnDescription: description,
      columnIdTeacher: idTeacher,
    };
  }
}