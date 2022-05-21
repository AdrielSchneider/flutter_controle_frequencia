import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/ui/management/evaluation_page.dart';

class TeamEvaluationPage extends StatefulWidget {
  const TeamEvaluationPage({Key? key}) : super(key: key);

  @override
  State<TeamEvaluationPage> createState() => _TeamEvaluationPageState();
}

class _TeamEvaluationPageState extends State<TeamEvaluationPage> {
  final _teamHelper = TeamHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione a turma para avaliar"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _teamHelper.findAll(),
          builder: (BuildContext context, AsyncSnapshot<List<Team>> snapshot) {
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
                        onTap: () => _openTeam(snapshot.data![index]),
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

  _openTeam(Team team) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EvaluationPage(
                  teamId: team.id!,
                )));

    setState(() {});
  }
}
