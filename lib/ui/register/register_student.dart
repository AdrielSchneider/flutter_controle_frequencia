import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';

class RegisterStudent extends StatefulWidget {
  RegisterStudent({Key? key, this.student}) : super(key: key);

  Student? student;

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final _studentHelper = StudentHelper();

  final TextEditingController _registerNumberController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student?.name ?? 'Cadastrar Aluno')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomTextField(
            inputTitle: 'Número de Registro',
            enabled: false,
            controller: _registerNumberController,
          ),
          CustomTextField(
            inputTitle: 'Nome',
            controller: _nameController,
          ),
          CustomTextField(
            inputTitle: 'CPF',
            controller: _cpfController,
          ),
          CustomTextField(
            inputTitle: 'E-mail',
            controller: _emailController,
          ),
          ElevatedButton(
              onPressed: () => _salvar(), child: const Text('Salvar'))
        ],
      )),
    );
  }

  _salvar() {
    _studentHelper.insert(Student(
        name: _nameController.text,
        cpf: _cpfController.text,
        registerDate: DateTime.now().toString(),
        email: _emailController.text));

    Navigator.pop(context);
  }
}
