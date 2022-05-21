import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/discipline_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_discipline_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/model/team_discipline.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class RegisterTeamPage extends StatefulWidget {
  RegisterTeamPage({Key? key, this.team}) : super(key: key);

  Team? team;

  @override
  State<RegisterTeamPage> createState() => _RegisterTeamPageState();
}

class _RegisterTeamPageState extends State<RegisterTeamPage> {
  final TeamHelper _teamHelper = TeamHelper();
  final DisciplineHelper _disciplineHelper = DisciplineHelper();
  final StudentHelper _studentHelper = StudentHelper();
  final TeamDisciplineHelper _teamDisciplineHelper = TeamDisciplineHelper();
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _periodController = TextEditingController(text: 'Manhã');

  List<int> _selectedStudents = List.empty(growable: true);
  List<int> _selectedDisciplines = List.empty(growable: true);

  List<Student> _studentsOptions = List.empty(growable: true);
  List<Discipline> _disciplinesOptions = List.empty(growable: true);

  @override
  void initState() {
    if (widget.team != null) {
      _idController.text = widget.team!.id.toString();
      _descriptionController.text = widget.team!.description;
      _periodController.text = widget.team!.period;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.team?.description ?? 'Cadastrar Turma'),
          actions: [
            Visibility(
              visible: widget.team?.id == null,
              child: IconButton(
                  onPressed: _limparCampos, icon: const Icon(Icons.clear)),
              replacement: IconButton(
                  onPressed: _excluirTurma, icon: const Icon(Icons.delete)),
            ),
            IconButton(onPressed: _salvarTurma, icon: const Icon(Icons.save))
          ],
        ),
        body: FutureBuilder(
          future: Future.wait([
            widget.team != null
                ? _studentHelper.findAll()
                : _studentHelper.findStudentsWithoutTeam(),
            _disciplineHelper.findAll(),
            _studentHelper.findByTeamId((widget.team?.id ?? -1)),
            _teamDisciplineHelper.findByTeamId((widget.team?.id ?? -1)),
          ]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _studentsOptions = snapshot.data![0];
              _disciplinesOptions = snapshot.data![1];
              _selectedStudents = (snapshot.data![2] as List<Student>)
                  .map((e) => e.registerNumber!)
                  .toList();
              _selectedDisciplines = (snapshot.data![3] as List<TeamDiscipline>)
                  .map((e) => e.idDiscipline)
                  .toList();

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
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Selecione um Período'),
                            items: <String>['Manhã', 'Tarde', 'Noite']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _periodController.text = value as String;
                            },
                            value: _periodController.text,
                            validator: (value) {
                              if (value == null) return '';
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: _showStudentMultiSelect,
                                child: const Text('Selecionar estudantes')),
                            ElevatedButton(
                                onPressed: _showDisciplinesMultiSelect,
                                child: const Text('Selecionar disciplinas'))
                          ],
                        )
                      ],
                    )),
              );
            }

            return Container();
          },
        ));
  }

  Future<void> _excluirTurma() async {
    await _teamHelper.delete(widget.team!);

    await _studentHelper.removeTeamId(widget.team!.id!);

    Utils.showToast(context, 'Turma excluída com sucesso');
    Navigator.pop(context);
  }

  void _limparCampos() {
    setState(() {
      _periodController.text = '';
      _descriptionController.text = '';
    });
  }

  _showStudentMultiSelect() {
    _showMultiSelect(
        context, _studentsOptions, _selectedStudents, _registerStudent);
  }

  _showDisciplinesMultiSelect() {
    _showMultiSelect(context, _disciplinesOptions, _selectedDisciplines,
        _registerDiscipline);
  }

  _registerStudent(value) {
    _selectedStudents = value;
  }

  _registerDiscipline(value) {
    _selectedDisciplines = value;
  }

  Future<void> _salvarTurma() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedStudents.isEmpty) {
      Utils.showToast(context, 'Selecione ao menos um estudante');
      return;
    }

    if (_selectedDisciplines.isEmpty) {
      Utils.showToast(context, 'Selecione ao menos uma disciplina');
      return;
    }

    Team teamToSave = Team(
        id: int.tryParse(_idController.text),
        description: _descriptionController.text,
        period: _periodController.text);
    bool saved = false;
    if (teamToSave.id == null) {
      Team t = await _teamHelper.insert(teamToSave);
      teamToSave.id = t.id;
      saved = (t.id != null);
    } else {
      saved = (await _teamHelper.update(teamToSave)) != -1;
    }

    if (saved) {
      for (var s in _selectedStudents) {
        _studentHelper.updateTeamId(teamToSave.id!, s);
      }

      for (var d in _selectedDisciplines) {
        _teamDisciplineHelper
            .insert(TeamDiscipline(idDiscipline: d, idTeam: teamToSave.id!));
      }

      Utils.showToast(context, "Turma salva com sucesso!");
      Navigator.pop(context);
    }
  }

  void _showMultiSelect(BuildContext context, List<dynamic> _itemsList,
      List<dynamic> _initialValue, Function(dynamic) func) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          cancelText: const Text('Cancelar'),
          confirmText: const Text('Confirmar'),
          title: const Text('Selecione'),
          items: _itemsList
              .map((e) => (e is Student
                  ? MultiSelectItem(e.registerNumber, e.name)
                  : MultiSelectItem(e.id, e.description)))
              .toList(),
          initialValue: _initialValue,
          onConfirm: (values) {
            func(values.map((e) => e as int).toList());
          },
        );
      },
    );
  }
}
