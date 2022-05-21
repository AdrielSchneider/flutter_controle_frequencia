import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:flutter_controle_frequencias/model/team.dart';
import 'package:flutter_controle_frequencias/ui/register/register_team_page.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final TeamHelper _teamHelper = TeamHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de turmas"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTeam(null),
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
                child: Text('Nenhuma turma localizada'),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _openTeam(Team? team) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterTeamPage(team: team)));

    setState(() {});
  }
}
