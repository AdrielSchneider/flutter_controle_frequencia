class Teacher {
  static const table = 'teacher';

  static const columnRegisterNumber = 'registerNumber';
  int? registerNumber;

  static const columnName = 'name';
  String name;

  static const columnCpf = 'cpf';
  String cpf;

  static const columnBirthday = 'birthday';
  String birthday;

  static const columnRegisterDate = 'registerDate';
  String registerDate;

  Teacher(
      {required this.name,
      required this.cpf,
      required this.birthday,
      required this.registerDate,
      this.registerNumber});

  factory Teacher.fromMap(Map map) {
    return Teacher(
        name: map[columnName],
        cpf: map[columnCpf],
        registerDate: map[columnRegisterDate],
        registerNumber: map[columnRegisterNumber],
        birthday: map[columnBirthday]);
  }

  Map<String, dynamic> toMap() {
    return {
      columnRegisterNumber: registerNumber,
      columnCpf: cpf,
      columnRegisterDate: registerDate,
      columnName: name,
      columnBirthday: birthday
    };
  }
}
