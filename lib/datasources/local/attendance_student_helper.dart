import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/attendance_student.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceStudentHelper {
  static const String createSQL = '''
  CREATE TABLE ${AttendanceStudent.table} (
    ${AttendanceStudent.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${AttendanceStudent.columnIdStudent} INTEGER,
    ${AttendanceStudent.columnAttendance} TEXT,
    FOREIGN KEY(${AttendanceStudent.columnIdStudent}) REFERENCES ${Student.table}(${Student.columnRegisterNumber})
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<AttendanceStudent> insert(AttendanceStudent attendance) async {
    attendance.id = await (await getDb())
        .insert(AttendanceStudent.table, attendance.toMap());
    return attendance;
  }

  Future<List<AttendanceStudent>> findByIdStudent(int idStudent) async {
    List dados = await (await getDb()).query(AttendanceStudent.table,
        where: '${AttendanceStudent.columnIdStudent} = ?', whereArgs: [idStudent]);
    return dados.map((e) => AttendanceStudent.fromMap(e)).toList();
  }

  Future<List<AttendanceStudent>> findAll() async {
    List dados = await (await getDb())
        .query(AttendanceStudent.table, orderBy: AttendanceStudent.columnId);

    return dados.map((e) => AttendanceStudent.fromMap(e)).toList();
  }
}
