import 'package:flutter/material.dart';

class DisciplinePage extends StatefulWidget {
  const DisciplinePage({Key? key}) : super(key: key);

  @override
  State<DisciplinePage> createState() => DdisciplineStatePage();
}

class DdisciplineStatePage extends State<DisciplinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de disciplinas"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => null,
      ),
    );
  }
}
