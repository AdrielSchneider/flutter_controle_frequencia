import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:sqflite/sqflite.dart';

class StudentHelper {
  static const String createSQL = '''
  CREATE TABLE ${Student.table} (
    ${Student.columnRegisterNumber} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Student.columnName} TEXT,
    ${Student.columnCpf} TEXT,
    ${Student.columnRegisterDate} TEXT,
    ${Student.columnEmail} TEXT,
    ${Student.columnStudentClass} INTEGER
    
  )''';

  //FOREIGN KEY(${Student.columnStudentClass}) REFERENCES ${Team.table}(${Team.id})

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Student> insert(Student student) async {
    student.registerNumber =
        await (await getDb()).insert(Student.table, student.toMap());
    return student;
  }

  Future<int> update(Student student) async {
    return (await getDb()).update(Student.table, student.toMap(),
        where: '${Student.columnRegisterNumber} = ?',
        whereArgs: [student.registerNumber]);
  }

  Future<int> delete(Student student) async {
    return (await getDb()).delete(Student.table,
        where: '${Student.columnRegisterNumber} = ?',
        whereArgs: [student.registerNumber]);
  }

  Future<List<Student>> findAll() async {
    List dados = await (await getDb())
        .query(Student.table, orderBy: Student.columnRegisterNumber);

    return dados.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> findStudentsWithoutTeam() async {
    List dados = await (await getDb())
        .query(Student.table, where: '${Student.columnStudentClass} IS NULL');

    return dados.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> findByTeamId(int teamId) async {
    List dados = await (await getDb()).query(Student.table,
        where: '${Student.columnStudentClass} = ?', whereArgs: [teamId]);
    return dados.map((e) => Student.fromMap(e)).toList();
  }

  Future<void> updateTeamId(int teamId, int studentId) async {
    String sql =
        'UPDATE ${Student.table} SET ${Student.columnStudentClass} = ? WHERE ${Student.columnRegisterNumber} = ?';

    await (await getDb()).rawUpdate(sql, [teamId, studentId]);
  }

  Future<void> removeTeamId(int teamId) async {
    String sql =
        'UPDATE ${Student.table} SET ${Student.columnStudentClass} = NULL WHERE ${Student.columnStudentClass} = ?';

    await (await getDb()).rawUpdate(sql, [teamId]);
  }
}
