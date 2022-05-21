class AttendanceStudent {
  static const table = 'attendanceStudent';

  static const columnId = 'id';
  int? id;

  static const columnIdStudent = 'idStudent';
  int idStudent;

  static const columnAttendance = 'attendance';
  bool attendance;

  AttendanceStudent(
      {this.id, required this.idStudent, required this.attendance});

  factory AttendanceStudent.fromMap(Map map) {
    return AttendanceStudent(
      id: map[columnId] ?? 0,
      idStudent: map[columnIdStudent],
      attendance: map[columnAttendance],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnIdStudent: idStudent,
      columnAttendance: attendance,
    };
  }
}
