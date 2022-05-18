import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/model/student.dart';

class StudentPage extends StatefulWidget {
  StudentPage({ Key? key, this.student }) : super(key: key);

  Student? student;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student?.name ?? "Novo aluno"), centerTitle: true,),
    );
  }
}