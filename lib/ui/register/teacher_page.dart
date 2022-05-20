import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/teacher_helper.dart';
import 'package:flutter_controle_frequencias/model/teacher.dart';
import 'package:flutter_controle_frequencias/ui/register/register_teacher_page.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  final _teacherHelper = TeacherHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de professores"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterTeacherPage())),
              }),
      body: FutureBuilder(
        future: _teacherHelper.findAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
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
                      onTap:() => _openTeacher(snapshot.data![index]),
                    );
                  });
            } else {
              return const Center(
                child: Text('Nenhum Professor localizado'),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _openTeacher(Teacher? teacher) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterTeacherPage(teacher: teacher)));
  }
}
