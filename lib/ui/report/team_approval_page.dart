import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/attendance_student_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/evaluation_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/attendance_student.dart';
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
  final _attendanceStudentHelper = AttendanceStudentHelper();

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
            _evaluationHelper.findByTeamId(widget.teamId),
            _attendanceStudentHelper.findAll(),
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
                List<AttendanceStudent> attendanceStudentList =
                    snapshot.data![2];

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
                                    style: const TextStyle(fontSize: 20),
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
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    _calculateAttendance(attendanceStudentList,
                                        studentsList[index].registerNumber!),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    _checkApproved(
                                        evaluationList
                                            .where((element) =>
                                                element.studentRegisterNumber ==
                                                studentsList[index]
                                                    .registerNumber)
                                            .first,
                                        attendanceStudentList),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
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

  String _calculateAttendance(
      List<AttendanceStudent> attendanceStudentList, int studentId) {
    int qtChamadas = 0, qtChamadaAluno = 0;

    for (AttendanceStudent attendanceStudent in attendanceStudentList) {
      if (attendanceStudent.idStudent == studentId) {
        qtChamadas += 1;
        if (attendanceStudent.attendance) {
          qtChamadaAluno += 1;
        }
      }
    }

    double total = (qtChamadaAluno * 100) / qtChamadas;

    return total.toStringAsFixed(0);
  }

  String _checkApproved(
      Evaluation evaluation, List<AttendanceStudent> attendanceStudentList) {
    if ((double.parse(_calculateAvg(evaluation)) >= 6) &&
        (double.parse(_calculateAttendance(
                attendanceStudentList, evaluation.studentRegisterNumber)) >
            70)) return 'Aprovado';

    return 'Reprovado';
  }
}
