import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/ui/components/menu_card.dart';
import 'package:flutter_controle_frequencias/ui/components/menu_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Controle de frequências"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            MenuTitle(title: "Cadastros"),
            GridView.count(
              crossAxisCount: 4,
                shrinkWrap: true,
              children: [
                MenuCard(icon: Icons.person_add, title: "Alunos"),
                MenuCard(icon: Icons.school, title: "Professores"),
                MenuCard(icon: Icons.book, title: "Disciplinas"),
                MenuCard(icon: Icons.people, title: "Turmas"),
              ],
            ),
            MenuTitle(title: "Gerenciamento"),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [
                MenuCard(icon: Icons.numbers, title: "Notas"),
                MenuCard(icon: Icons.check, title: "Frequências")
              ],
            ),
            Flexible(child: Container(),)
          ],
        ));
  }
}
