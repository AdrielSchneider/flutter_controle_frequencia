import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';

class RegisterStudent extends StatefulWidget {
  RegisterStudent({Key? key, this.student}) : super(key: key);

  Student? student;

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student?.name ?? 'Cadastrar Aluno')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomTextField(inputTitle: 'Número de Registro', enabled: false),
          CustomTextField(inputTitle: 'Nome'),
          CustomTextField(
            inputTitle: 'CPF',
          )
        ],
      )),
    );
  }
}
