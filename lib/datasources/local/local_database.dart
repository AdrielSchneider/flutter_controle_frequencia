import 'package:flutter_controle_frequencias/datasources/local/attendance_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/attendance_student_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/discipline_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/teacher_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_discipline_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static const String _databaseName = 'controle_frequencia.db';

  static final LocalDatabase _instance = LocalDatabase.internal();

  factory LocalDatabase() => _instance;

  LocalDatabase.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _databaseName);

    return await openDatabase(pathDb, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(StudentHelper.createSQL);
      await db.execute(TeacherHelper.createSQL);
      await db.execute(TeamHelper.createSQL);
      await db.execute(DisciplineHelper.createSQL);
      await db.execute(TeamDisciplineHelper.createSQL);
      await db.execute(AttendanceHelper.createSQL);
      await db.execute(AttendanceStudentHelper.createSQL);
    });
  }

  void close() async {
    Database myDb = await db;
    myDb.close();
  }
}
