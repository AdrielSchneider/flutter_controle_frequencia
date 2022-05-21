import 'package:flutter_controle_frequencias/model/attendance_student.dart';
import 'package:flutter_controle_frequencias/model/student.dart';

class AttendanceStudentHelper {
  static const String createSQL = '''
  CREATE TABLE ${AttendanceStudent.table} (
    ${AttendanceStudent.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${AttendanceStudent.columnIdStudent} INTEGER,
    ${AttendanceStudent.columnAttendance} TEXT,
    FOREIGN KEY(${AttendanceStudent.columnIdStudent}) REFERENCES ${Student
      .table}(${Student.columnRegisterNumber})
  )''';
}