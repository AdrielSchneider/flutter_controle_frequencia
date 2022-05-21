import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/model/team_discipline.dart';
import 'package:sqflite/sqflite.dart';

import 'local_database.dart';

class TeamDisciplineHelper {
  static const createSQL = '''
    CREATE TABLE ${TeamDiscipline.table} (
      ${TeamDiscipline.columnIdDiscipline} INTEGER ,
      ${TeamDiscipline.columnIdTeam} INTEGER,
      FOREIGN KEY(${TeamDiscipline.columnIdTeam}) REFERENCES ${Team.table}(${Team.columnId}),
      FOREIGN KEY(${TeamDiscipline.columnIdDiscipline}) REFERENCES ${Discipline.table}(${Discipline.columnId})
    )
  ''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<List<TeamDiscipline>> findByTeamId(int teamId) async {
    List dados = await (await getDb()).query(TeamDiscipline.table,
        where: '${TeamDiscipline.columnIdTeam} = ?', whereArgs: [teamId]);
    return dados.map((e) => TeamDiscipline.fromMap(e)).toList();
  }

  Future<TeamDiscipline> insert(TeamDiscipline teamDiscipline) async {
    await (await getDb()).insert(TeamDiscipline.table, teamDiscipline.toMap());
    return teamDiscipline;
  }
}
