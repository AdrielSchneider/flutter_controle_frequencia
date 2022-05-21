import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/discipline_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/teacher_helper.dart';
import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class RegisterDisciplinePage extends StatefulWidget {
  RegisterDisciplinePage({Key? key, this.discipline}) : super(key: key);

  Discipline? discipline;

  @override
  State<RegisterDisciplinePage> createState() => _RegisterDisciplinePageState();
}

class _RegisterDisciplinePageState extends State<RegisterDisciplinePage> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _idController = TextEditingController();
  int? _selectedTeacher;

  final _teacherHelper = TeacherHelper();
  final _disciplineHelper = DisciplineHelper();

  List<Teacher> teacherList = List.empty(growable: true);

  Future getTeacher() async {
    teacherList = await _teacherHelper.findAll();
  }

  Future<void> _salvarDisciplina() async {
    if (!_formKey.currentState!.validate()) return;

    Discipline disciplinetoSave = Discipline(
        id: int.tryParse(_idController.text),
        description: _descriptionController.text,
        idTeacher: _selectedTeacher!);

    bool saved = false;

    if (disciplinetoSave.id == null) {
      Discipline d = await _disciplineHelper.insert(disciplinetoSave);
      saved = (d.id != null);
    } else {
      saved = (await _disciplineHelper.update(disciplinetoSave)) != -1;
    }

    if (saved) {
      Utils.showToast(context, "Disciplina salva com sucesso!");
      Navigator.pop(context);
    }
  }

  Future<void> _excluirDisciplina() async {
    await _disciplineHelper.delete(widget.discipline!);
    Utils.showToast(context, 'Disciplina excluída com sucesso');
    Navigator.pop(context);
  }

  void _limparCampos() {
    setState(() {
      _selectedTeacher = null;
      _descriptionController.text = '';
    });
  }

  @override
  void initState() {
    if (widget.discipline != null) {
      _idController.text = widget.discipline!.id!.toString();
      _descriptionController.text = widget.discipline!.description;
      _selectedTeacher = widget.discipline!.idTeacher;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discipline?.description ?? 'Cadastrar Disciplina'),
        actions: [
          Visibility(
            visible: widget.discipline?.id == null,
            child: IconButton(
                onPressed: _limparCampos, icon: const Icon(Icons.clear)),
            replacement: IconButton(
                onPressed: _excluirDisciplina, icon: const Icon(Icons.delete)),
          ),
          IconButton(onPressed: _salvarDisciplina, icon: Icon(Icons.save))
        ],
      ),
      body: FutureBuilder(
        future: getTeacher(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    inputTitle: 'Descrição',
                    controller: _descriptionController,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Selecione um professor',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) return '';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedTeacher = value as int;
                        });
                      },
                      items: teacherList.map((e) {
                        return DropdownMenuItem<int>(
                          value: e.registerNumber!,
                          child: Text(e.name),
                        );
                      }).toList(),
                      value: _selectedTeacher,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
