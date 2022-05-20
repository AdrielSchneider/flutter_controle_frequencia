import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/model/team_discipline.dart';

class TeamDisciplineHelper {

  static const createSQL = '''
    CREATE TABLE ${TeamDiscipline.table} (
      ${TeamDiscipline.columnIdDiscipline} INTEGER ,
      ${TeamDiscipline.columnIdTeam} INTEGER,
      FOREIGN KEY(${TeamDiscipline.columnIdTeam}) REFERENCES ${Team.table}(${Team.columnId}),
      FOREIGN KEY(${TeamDiscipline.columnIdDiscipline}) REFERENCES ${Discipline.table}(${Discipline.columnId})
    )
  ''';

}