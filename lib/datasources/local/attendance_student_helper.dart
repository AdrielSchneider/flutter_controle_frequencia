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
}
