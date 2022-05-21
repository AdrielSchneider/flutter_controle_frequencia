import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:sqflite/sqflite.dart';

class DisciplineHelper {
  static const String createSQL = '''
  CREATE TABLE ${Discipline.table} (
    ${Discipline.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Discipline.columnDescription} TEXT,
    ${Discipline.columnIdTeacher} INTEGER,
    FOREIGN KEY(${Discipline.columnIdTeacher}) REFERENCES ${Teacher.table}(${Teacher.columnRegisterNumber})
  )''';
  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Discipline> insert(Discipline discipline) async {
    discipline.id =
        await (await getDb()).insert(Discipline.table, discipline.toMap());
    return discipline;
  }

  Future<int> update(Discipline discipline) async {
    return (await getDb()).update(Discipline.table, discipline.toMap(),
        where: '${Discipline.columnId} = ?', whereArgs: [discipline.id]);
  }

  Future<int> delete(Discipline discipline) async {
    return (await getDb()).delete(Discipline.table,
        where: '${Discipline.columnId} = ?', whereArgs: [discipline.id]);
  }

  Future<List<Discipline>> findAll() async {
    List dados = await (await getDb())
        .query(Discipline.table, orderBy: Discipline.columnId);

    return dados.map((e) => Discipline.fromMap(e)).toList();
  }
}
