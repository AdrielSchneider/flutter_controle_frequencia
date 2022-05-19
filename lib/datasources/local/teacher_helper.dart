import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:sqflite/sqflite.dart';

class TeacherHelper {
  static const String createSQL = '''
  CREATE TABLE ${Teacher.table} (
    ${Teacher.columnRegisterNumber} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Teacher.columnName} TEXT,
    ${Teacher.columnCpf} TEXT,
    ${Teacher.columnRegisterDate} TEXT,
    ${Teacher.columnBirthday} TEXT
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Teacher> insert(Teacher teacher) async {
    teacher.registerNumber =
    await (await getDb()).insert(Teacher.table, teacher.toMap());
    return teacher;
  }

  Future<int> update(Teacher teacher) async {
    return (await getDb()).update(Teacher.table, teacher.toMap(),
        where: '${Teacher.columnRegisterNumber} = ?',
        whereArgs: [teacher.registerNumber]);
  }

  Future<int> delete(Teacher teacher) async {
    return (await getDb()).delete(Teacher.table,
        where: '${Teacher.columnRegisterNumber} = ?',
        whereArgs: [teacher.registerNumber]);
  }

  Future<List<Teacher>> findAll() async {
    List dados = await (await getDb())
        .query(Teacher.table, orderBy: Teacher.columnRegisterNumber);

    return dados.map((e) => Teacher.fromMap(e)).toList();
  }
}