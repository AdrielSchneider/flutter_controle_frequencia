import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/attendance.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceHelper {
  static const String createSQL = '''
  CREATE TABLE ${Attendance.table} (
    ${Attendance.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Attendance.columnIdTeam} INTEGER,
    ${Attendance.columnAttendanceDate} TEXT,
    FOREIGN KEY(${Attendance.columnIdTeam}) REFERENCES ${Team.table}(${Team.columnId})
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Attendance> insert(Attendance attendance) async {
    attendance.id =
        await (await getDb()).insert(Attendance.table, attendance.toMap());
    return attendance;
  }

  Future<List<Attendance>> findByTeamId(int teamId) async {
    List dados = await (await getDb()).query(Attendance.table,
        where: '${Attendance.columnIdTeam} = ?', whereArgs: [teamId]);
    return dados.map((e) => Attendance.fromMap(e)).toList();
  }
}
