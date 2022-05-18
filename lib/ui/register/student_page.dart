import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/ui/register/register_student.dart';

class StudentPage extends StatefulWidget {
  StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de alunos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterStudent()))
        },
      ),
    );
  }
}
