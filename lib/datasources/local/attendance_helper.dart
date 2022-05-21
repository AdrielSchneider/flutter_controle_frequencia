import 'package:flutter_controle_frequencias/model/attendance.dart';
import 'package:flutter_controle_frequencias/model/team.dart';

class AttendanceHelper {
  static const String createSQL = '''
  CREATE TABLE ${Attendance.table} (
    ${Attendance.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Attendance.columnIdTeam} INTEGER,
    ${Attendance.columnAttendanceDate} TEXT,
    FOREIGN KEY(${Attendance.columnIdTeam}) REFERENCES ${Team.table}(${Team.columnId})
  )''';

}