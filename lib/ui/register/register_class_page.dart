import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class RegisterClassPage extends StatefulWidget {
  RegisterClassPage({Key? key, this.team}) : super(key: key);

  Team? team;



  @override
  State<RegisterClassPage> createState() => _RegisterClassPageState();
}

class _RegisterClassPageState extends State<RegisterClassPage> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _period;

  final _teamHelper = TeamHelper();

  Future<void> _salvarTurma() async {
    if (!_formKey.currentState!.validate()) return;

    Team teamToSave = Team(
        id: int.tryParse(_idController.text),
        description: _descriptionController.text,
        period: _period!
    );

    bool saved = false;

    if (teamToSave.id == null) {
      Team t = await _teamHelper.insert(teamToSave);
      saved = (t.id != null);
    } else {
      saved = (await _teamHelper.update(teamToSave)) != -1;
    }

    if (saved) {
      Utils.showToast(context, "Turma salva com sucesso!");
      Navigator.pop(context);
    }

  }

  Future<void> _excluirTurma() async {
    await _teamHelper.delete(widget.team!);
    Utils.showToast(context, 'Turma excluída com sucesso');
    Navigator.pop(context);
  }

  void _limparCampos() {
    setState(() {
      _period = null;
      _descriptionController.text = '';
    });

  }

  @override
  void initState() {
    if (widget.team != null) {
      _idController.text =
          widget.team!.id!.toString();
      _descriptionController.text = widget.team!.description;
      _period = widget.team!.period;
    }
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
          IconButton(onPressed: _salvarTurma, icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
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
                  items: <String>['1º Período', '2º Período', '3º Período', '4º Período'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _period = value as String;
                  },
                  value: _period,
                  validator: (value) {
                    if (value == null) return '';
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
