import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/register/register_student_page.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _studentHelper = StudentHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de alunos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {_openStudent(null)},
      ),
      body: FutureBuilder(
          future: _studentHelper.findAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              snapshot.data![index].name,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
                        onTap: () => _openStudent(snapshot.data![index]),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Nenhum estudante localizado'),
                );
              }
            } else {
              return Container();
            }
          }),
    );
  }

  _openStudent(Student? student) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterStudent(student: student)));

    setState(() {});
  }
}
