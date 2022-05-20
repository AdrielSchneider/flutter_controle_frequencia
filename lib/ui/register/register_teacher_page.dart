import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/teacher_helper.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class RegisterTeacherPage extends StatefulWidget {
  RegisterTeacherPage({Key? key, this.teacher}) : super(key: key);

  Teacher? teacher;

  @override
  State<RegisterTeacherPage> createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  final _registerNumberController = TextEditingController();
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
    Teacher teachertoSave = Teacher(
        registerNumber: int.tryParse(_registerNumberController.text),
        name: _nomeController.text,
        cpf: _cpfController.text,
        birthday: _dtNascimentoController.text,
        registerDate: _dtCadastroController.text);

    bool saved = false;

    if (teachertoSave.registerNumber == null) {
      Teacher t = await _teacherHelper.insert(teachertoSave);
      saved = (t.registerNumber != null);
    } else {
      saved = (await _teacherHelper.update(teachertoSave)) != -1;
    }

    if (saved) {
      Utils.showToast(context, "Professor salvo com sucesso!");
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (widget.teacher != null) {
      _registerNumberController.text =
          widget.teacher!.registerNumber!.toString();
      _nomeController.text = widget.teacher!.name;
      _cpfController.text = widget.teacher!.cpf;
      _dtNascimentoController.text = widget.teacher!.birthday;
      _dtCadastroController.text = widget.teacher!.registerDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher?.name ?? 'Cadastrar Professor'),
        actions: [
          IconButton(onPressed: _limparCampos, icon: Icon(Icons.clear)),
          IconButton(onPressed: _salvarCampos, icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              inputTitle: 'Registro',
              controller: _registerNumberController,
              enabled: false,
            ),
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
