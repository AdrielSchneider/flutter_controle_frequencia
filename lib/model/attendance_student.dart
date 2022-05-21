class AttendanceStudent {
  static const table = 'attendanceStudent';

  static const columnId = 'id';
  int? id;

  static const columnIdStudent = 'idStudent';
  int idStudent;

  static const columnAttendance = 'attendance';
  String attendanceDate;

  AttendanceStudent({this.id, required this.idStudent, required this.attendanceDate});

  factory AttendanceStudent.fromMap(Map map) {
    return AttendanceStudent(
      id: map[columnId] ?? 0,
      idStudent: map[columnIdStudent],
      attendanceDate: map[columnAttendance],);
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnIdStudent: idStudent,
      columnAttendance: attendanceDate,
    };
  }
}