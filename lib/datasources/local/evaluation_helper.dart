import 'package:flutter_controle_frequencias/datasources/local/local_database.dart';
import 'package:flutter_controle_frequencias/model/evaluation.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:sqflite/sqflite.dart';

class EvaluationHelper {
  static const String createSQL = '''
  CREATE TABLE ${Evaluation.table} (
    ${Evaluation.columnStudentRegisterNumber} INTEGER,
    ${Evaluation.columnTeamId} INTEGER,
    ${Evaluation.columnFirstNote} NUMERIC,
    ${Evaluation.columnSecondNote} NUMERIC,
    ${Evaluation.columnThirdNote} NUMERIC,
    ${Evaluation.columnFourthNote} NUMERIC,
    FOREIGN KEY(${Evaluation.columnTeamId}) REFERENCES ${Team.table}(${Team.columnId}),
    PRIMARY KEY (${Evaluation.columnTeamId}, ${Evaluation.columnStudentRegisterNumber})
  )''';

  Future<Database> getDb() async {
    return (await LocalDatabase().db);
  }

  Future<Evaluation> insert(Evaluation evaluation) async {
    await (await getDb()).insert(Evaluation.table, evaluation.toMap());
    return evaluation;
  }

  Future<List<Evaluation>> findByTeamId(int teamId) async {
    List dados = await (await getDb()).query(Evaluation.table,
        where: '${Evaluation.columnTeamId} = ?', whereArgs: [teamId]);
    return dados.map((e) => Evaluation.fromMap(e)).toList();
  }
}
