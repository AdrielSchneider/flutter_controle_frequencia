import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/evaluation_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/evaluation.dart';
import 'package:flutter_controle_frequencias/model/student.dart';

class TeamApprovalPage extends StatefulWidget {
  TeamApprovalPage({Key? key, required this.teamId}) : super(key: key);

  int teamId;

  @override
  State<TeamApprovalPage> createState() => _TeamApprovalPageState();
}

class _TeamApprovalPageState extends State<TeamApprovalPage> {
  final _studentHelper = StudentHelper();
  final _evaluationHelper = EvaluationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alunos avaliados"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Future.wait([
            _studentHelper.findByTeamId(widget.teamId),
            _evaluationHelper.findByTeamId(widget.teamId)
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                List<Student> studentsList = snapshot.data![0];
                List<Evaluation> evaluationList = snapshot.data![1];

                return ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: studentsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    studentsList[index].name,
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    _calculateAvg(evaluationList
                                        .where((element) =>
                                            element.studentRegisterNumber ==
                                            studentsList[index].registerNumber)
                                        .first),
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    _calculateAvg(evaluationList
                                        .where((element) =>
                                            element.studentRegisterNumber ==
                                            studentsList[index].registerNumber)
                                        .first),
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    _checkApproved(evaluationList
                                        .where((element) =>
                                            element.studentRegisterNumber ==
                                            studentsList[index].registerNumber)
                                        .first),
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                )
                              ],
                            )),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Nenhum estudante localizado'),
                );
              }
            } else {
              return Container();
            }
          }),
    );
  }

  String _calculateAvg(Evaluation evaluation) {
    return ((evaluation.firstNote +
                evaluation.secondNote +
                evaluation.thirdNote +
                evaluation.fourthNote) /
            4)
        .toStringAsFixed(1);
  }

  String _checkApproved(Evaluation evaluation) {
    if (double.parse(_calculateAvg(evaluation)) > 7.5) return 'Aprovado';

    return 'Reprovado';
  }
}
