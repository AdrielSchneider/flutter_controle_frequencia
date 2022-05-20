import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:sqflite/sqflite.dart';

class TeamHelper {
  static const String createSQL = '''
  CREATE TABLE ${Team.table} (
    ${Team.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Team.columnDescription} TEXT,
    ${Team.columnPeriod} TEXT
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Team> insert(Team team) async {
    team.id =
    await (await getDb()).insert(Team.table, team.toMap());
    return team;
  }

  Future<int> update(Team team) async {
    return (await getDb()).update(Team.table, team.toMap(),
        where: '${Team.columnId} = ?',
        whereArgs: [team.id]);
  }

  Future<int> delete(Team team) async {
    return (await getDb()).delete(Team.table,
        where: '${Team.columnId} = ?',
        whereArgs: [team.id]);
  }

  Future<List<Team>> findAll() async {
    List dados = await (await getDb())
        .query(Team.table, orderBy: Team.columnId);

    return dados.map((e) => Team.fromMap(e)).toList();
  }
}