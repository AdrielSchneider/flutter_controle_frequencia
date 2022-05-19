class Student {
  static const table = 'student';

  static const columnRegisterNumber = 'registerNumber';
  int? registerNumber;

  static const columnName = 'name';
  String name;

  static const columnCpf = 'cpf';
  String cpf;

  // static const columnBirthday = 'birthday';
  // DateTime birthday;

  static const columnRegisterDate = 'registerDate';
  String registerDate;

  static const columnEmail = 'email';
  String email;

  Student(
      {required this.name,
      required this.cpf,
      // required this.birthday,
      required this.registerDate,
      this.registerNumber,
      required this.email});

  factory Student.fromMap(Map map) {
    return Student(
        name: map[columnName],
        cpf: map[columnCpf],
        registerDate: map[columnRegisterDate],
        registerNumber: map[columnRegisterNumber] ?? 0,
        email: map[columnEmail]);
  }

  Map<String, dynamic> toMap() {
    return {
      columnRegisterNumber: registerNumber,
      columnCpf: cpf,
      columnRegisterDate: registerDate,
      columnName: name,
      columnEmail: email
    };
  }
}
