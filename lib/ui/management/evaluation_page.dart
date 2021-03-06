import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/evaluation_helper.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/evaluation.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';
import 'package:flutter_controle_frequencias/ui/components/utils.dart';

class EvaluationPage extends StatefulWidget {
  EvaluationPage({Key? key, required this.teamId}) : super(key: key);

  int teamId;

  @override
  State<EvaluationPage> createState() => EevaluationStatePage();
}

class EevaluationStatePage extends State<EvaluationPage> {
  final StudentHelper _studentHelper = StudentHelper();
  final _evaluationHelper = EvaluationHelper();

  Map<int, List<TextEditingController>> controllers = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliação de Alunos'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _limparCampos, icon: const Icon(Icons.clear)),
          IconButton(onPressed: _saveEvaluation, icon: const Icon(Icons.save))
        ],
      ),
      body: FutureBuilder(
        future: _studentHelper.findByTeamId(widget.teamId),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: _formKey,
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Student student = snapshot.data![index];
                    TextEditingController firstController =
                        TextEditingController(text: '');
                    TextEditingController secondController =
                        TextEditingController(text: '');
                    TextEditingController thirdController =
                        TextEditingController(text: '');
                    TextEditingController fourthController =
                        TextEditingController(text: '');

                    controllers.putIfAbsent(
                        student.registerNumber!,
                        () => [
                              firstController,
                              secondController,
                              thirdController,
                              fourthController
                            ]);

                    return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  student.name,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '1º',
                                    controller: controllers[
                                        student.registerNumber!]![0],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                    onNullMessage: '',
                                    minDoubleValue: 0,
                                    maxDoubleValue: 10,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '2º',
                                    controller: controllers[
                                        student.registerNumber!]![1],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                    onNullMessage: '',
                                    minDoubleValue: 0,
                                    maxDoubleValue: 10,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '3º',
                                    controller: controllers[
                                        student.registerNumber!]![2],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                    onNullMessage: '',
                                    minDoubleValue: 0,
                                    maxDoubleValue: 10,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '4º',
                                    controller: controllers[
                                        student.registerNumber!]![3],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                    onNullMessage: '',
                                    minDoubleValue: 0,
                                    maxDoubleValue: 10,
                                  )),
                            ],
                          )),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _saveEvaluation() {
    if (!_formKey.currentState!.validate()) {
      Utils.showToast(
          context, 'Preencha todos os campos com valores de 0 a 10');
      return;
    }

    for (var key in controllers.keys) {
      _evaluationHelper.insert(Evaluation(
          teamId: widget.teamId,
          studentRegisterNumber: key,
          firstNote: double.parse(controllers[key]![0].text),
          secondNote: double.parse(controllers[key]![1].text),
          thirdNote: double.parse(controllers[key]![2].text),
          fourthNote: double.parse(controllers[key]![3].text)));
    }

    Utils.showToast(context, "Avaliação salva com sucesso!");
    Navigator.pop(context);
  }

  _limparCampos() {
    for (var key in controllers.keys) {
      controllers[key]![0].text = '';
      controllers[key]![1].text = '';
      controllers[key]![2].text = '';
      controllers[key]![3].text = '';
    }
  }
}
