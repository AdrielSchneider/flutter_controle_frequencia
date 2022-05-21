import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/team_helper.dart';
import 'package:flutter_controle_frequencias/model/team.dart';

import 'team_approval_page.dart';

class StudentApprovalPage extends StatefulWidget {
  const StudentApprovalPage({Key? key}) : super(key: key);

  @override
  State<StudentApprovalPage> createState() => StudentAapprovalPageState();
}

class StudentAapprovalPageState extends State<StudentApprovalPage> {
  final _teamHelper = TeamHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione a turma"),
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
                  child: Text('Nenhuma turma localizada'),
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
            builder: (context) => TeamApprovalPage(
                  teamId: team.id!,
                )));

    setState(() {});
  }
}
