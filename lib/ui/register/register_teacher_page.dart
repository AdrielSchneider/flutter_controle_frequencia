import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/teacher_helper.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class RegisterTeacherPage extends StatefulWidget {
  const RegisterTeacherPage({Key? key}) : super(key: key);

  @override
  State<RegisterTeacherPage> createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dtNascimentoController = TextEditingController();
  final _dtCadastroController = TextEditingController();
  final _teacherHelper = TeacherHelper();

  void _limparCampos() {
    setState(() {
      _nomeController.text = '';
      _cpfController.text = '';
      _dtNascimentoController.text = '';
      _dtCadastroController.text = '';
    });
  }

  void _salvarCampos() async {
    Teacher teacher = await _teacherHelper.insert(Teacher(
        name: _nomeController.text,
        cpf: _cpfController.text,
        birthday: _dtNascimentoController.text,
        registerDate: _dtCadastroController.text));

    if (teacher.registerNumber != null) {
      Utils.showToast(context, "Professor salvo com sucesso!");
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Professor'),
        actions: [
          IconButton(onPressed: _limparCampos, icon: Icon(Icons.clear)),
          IconButton(onPressed: _salvarCampos, icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              inputTitle: 'Nome',
              controller: _nomeController,
            ),
            CustomTextField(
              inputTitle: 'CPF',
              controller: _cpfController,
            ),
            CustomTextField(
              inputTitle: 'Dt. Nascimento',
              controller: _dtNascimentoController,
            ),
            CustomTextField(
              inputTitle: 'Dt. Cadastro',
              controller: _dtCadastroController,
            ),
          ],
        ),
      ),
    );
  }
}
