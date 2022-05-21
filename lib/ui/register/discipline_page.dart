import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/discipline_helper.dart';
import 'package:flutter_controle_frequencias/model/discipline.dart';
import 'package:flutter_controle_frequencias/ui/register/register_discipline_page.dart';

class DisciplinePage extends StatefulWidget {
  const DisciplinePage({Key? key}) : super(key: key);

  @override
  State<DisciplinePage> createState() => DisciplineStatePage();
}

class DisciplineStatePage extends State<DisciplinePage> {
  final _disciplineHelper = DisciplineHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de disciplinas"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTeacher(null),
      ),
      body: FutureBuilder(
        future: _disciplineHelper.findAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Discipline>> snapshot) {
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
                            snapshot.data![index].description,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                      onTap: () => _openTeacher(snapshot.data![index]),
                    );
                  });
            } else {
              return const Center(
                child: Text('Nenhuma Disciplina localizada'),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _openTeacher(Discipline? discipline) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegisterDisciplinePage(discipline: discipline)));
    setState(() {});
  }
}
