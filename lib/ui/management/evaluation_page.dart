import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/custom_text_field.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({Key? key}) : super(key: key);

  @override
  State<EvaluationPage> createState() => EevaluationStatePage();
}

class EevaluationStatePage extends State<EvaluationPage> {
  final StudentHelper _studentHelper = StudentHelper();

  Map<int, List<TextEditingController>> controllers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliação de Alunos'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _studentHelper.findAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TextEditingController firstController =
                      TextEditingController();
                  TextEditingController secondController =
                      TextEditingController();
                  TextEditingController thirdController =
                      TextEditingController();
                  TextEditingController fourthController =
                      TextEditingController();

                  controllers.putIfAbsent(
                      index,
                      () => [
                            firstController,
                            secondController,
                            thirdController,
                            fourthController
                          ]);

                  return GestureDetector(
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  snapshot.data![index].name,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '1º',
                                    controller: controllers[index]![0],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '2º',
                                    controller: controllers[index]![1],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '3º',
                                    controller: controllers[index]![2],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: CustomTextField(
                                    inputTitle: '4º',
                                    controller: controllers[index]![3],
                                    margin: 1.0,
                                    textInputType:
                                        const TextInputType.numberWithOptions(),
                                  )),
                            ],
                          )),
                    ),
                    onTap: () => _evaluateStudent(snapshot.data![index]),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _evaluateStudent(Student student) {}
}
