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
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(icon: Icons.person_add, title: "Alunos", onTapFunc: () => null,),
                MenuCard(icon: Icons.school, title: "Professores", onTapFunc: () => null,),
                MenuCard(icon: Icons.book, title: "Disciplinas", onTapFunc: () => null,),
                MenuCard(icon: Icons.people, title: "Turmas", onTapFunc: () => null,),
              ],
            ),
            MenuTitle(title: "Gerenciamento"),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(icon: Icons.numbers, title: "Notas", onTapFunc: () => null,),
                MenuCard(icon: Icons.check, title: "Frequências", onTapFunc: () => null,)
              ],
            ),
            MenuTitle(title: "Relatórios"),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(icon: Icons.checklist, title: "Aprovação de alunos", onTapFunc: () => null,),
              ],
            ),
          ],
        ));
  }
}
