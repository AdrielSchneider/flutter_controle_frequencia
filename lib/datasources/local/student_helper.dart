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
    ${Student.columnEmail} TEXT
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Student> insert(Student student) async {
    student.registerNumber =
        await (await getDb()).insert(Student.table, student.toMap());
    return student;
  }
}
