import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class RegisterStudent extends StatefulWidget {
  RegisterStudent({Key? key, this.student}) : super(key: key);

  Student? student;

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final _studentHelper = StudentHelper();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _registerNumberController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    if (widget.student != null) {
      _registerNumberController.text =
          widget.student!.registerNumber!.toString();
      _nameController.text = widget.student!.name;
      _cpfController.text = widget.student!.cpf;
      _emailController.text = widget.student!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.student?.name ?? 'Cadastrar Aluno'),
          actions: [
            Visibility(
              visible: widget.student?.registerNumber == null,
              child: IconButton(
                  onPressed: _limparCampos, icon: const Icon(Icons.clear)),
              replacement: IconButton(
                  onPressed: _excluir, icon: const Icon(Icons.delete)),
            ),
            IconButton(onPressed: _salvar, icon: const Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
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
                ],
              )),
        ));
  }

  void _limparCampos() {
    setState(() {
      _nameController.text = '';
      _cpfController.text = '';
      _emailController.text = '';
    });
  }

  Future<void> _excluir() async {
    await _studentHelper.delete(widget.student!);

    Utils.showToast(context, 'Aluno excluído com sucesso');
    Navigator.pop(context);
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    Student studentToSave = Student(
        registerNumber: int.tryParse(_registerNumberController.text),
        name: _nameController.text,
        cpf: _cpfController.text,
        registerDate: DateTime.now().toString(),
        email: _emailController.text);

    bool saved = false;

    if (studentToSave.registerNumber == null) {
      Student s = await _studentHelper.insert(studentToSave);
      saved = (s.registerNumber != null);
    } else {
      saved = (await _studentHelper.update(studentToSave)) != -1;
    }

    if (saved) {
      Utils.showToast(context, "Estudante salvo com sucesso!");
      Navigator.pop(context);
    }
  }
}
