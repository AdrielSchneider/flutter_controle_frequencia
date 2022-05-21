class Attendance {
  static const table = 'attendance';

  static const columnId = 'id';
  int? id;

  static const columnIdTeam = 'idTeam';
  int idTeam;

  static const columnAttendanceDate = 'attendanceDate';
  String attendanceDate;

  Attendance({this.id, required this.idTeam, required this.attendanceDate});

  factory Attendance.fromMap(Map map) {
    return Attendance(
      id: map[columnId] ?? 0,
      idTeam: map[columnIdTeam],
      attendanceDate: map[columnAttendanceDate],);
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnIdTeam: idTeam,
      columnAttendanceDate: attendanceDate,
    };
  }


}