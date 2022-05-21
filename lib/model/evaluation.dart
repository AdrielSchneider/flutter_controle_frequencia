class Evaluation {
  static const table = 'evaluation';

  static const columnTeamId = 'teamId';
  int teamId;

  static const columnStudentRegisterNumber = 'studentRegisterNumber';
  int studentRegisterNumber;

  static const column = 'firstNote';
  double firstNote;

  static const columnSecondNote = 'secondNote';
  double secondNote;

  static const columnThirdNote = 'thirdNote';
  double thirdNote;

  static const columnFourthNote = 'fourthNote';
  double fourthNote;

  Evaluation(this.teamId, this.studentRegisterNumber, this.firstNote,
      this.secondNote, this.thirdNote, this.fourthNote);
}
