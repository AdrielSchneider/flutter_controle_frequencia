import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';

class DisciplineHelper {
  static const String createSQL = '''
  CREATE TABLE ${Discipline.table} (
    ${Discipline.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Discipline.columnDescription} TEXT,
    ${Discipline.columnIdTeacher} INTEGER,
    FOREIGN KEY(${Discipline.columnIdTeacher}) REFERENCES ${Teacher.table}(${Teacher.columnRegisterNumber})
  )''';

}
