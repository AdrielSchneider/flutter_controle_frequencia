class Evaluation {
  static const table = 'evaluation';

  static const columnTeamId = 'teamId';
  int teamId;

  static const columnStudentRegisterNumber = 'studentRegisterNumber';
  int studentRegisterNumber;

  static const columnFirstNote = 'firstNote';
  double firstNote;

  static const columnSecondNote = 'secondNote';
  double secondNote;

  static const columnThirdNote = 'thirdNote';
  double thirdNote;

  static const columnFourthNote = 'fourthNote';
  double fourthNote;

  Evaluation(
      {required this.teamId,
      required this.studentRegisterNumber,
      required this.firstNote,
      required this.secondNote,
      required this.thirdNote,
      required this.fourthNote});

  factory Evaluation.fromMap(Map map) {
    return Evaluation(
        teamId: map[columnTeamId],
        firstNote: map[columnFirstNote].toDouble(),
        secondNote: map[columnSecondNote].toDouble(),
        thirdNote: map[columnThirdNote].toDouble(),
        fourthNote: map[columnFourthNote].toDouble(),
        studentRegisterNumber: map[columnStudentRegisterNumber]);
  }

  Map<String, dynamic> toMap() {
    return {
      columnTeamId: teamId,
      columnStudentRegisterNumber: studentRegisterNumber,
      columnFirstNote: firstNote,
      columnSecondNote: secondNote,
      columnThirdNote: thirdNote,
      columnFourthNote: fourthNote
    };
  }
}
