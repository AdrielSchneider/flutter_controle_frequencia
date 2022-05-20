import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/ui/components/menu_card.dart';
import 'package:flutter_controle_frequencias/ui/components/menu_title.dart';
import 'package:flutter_controle_frequencias/ui/management/attendance_page.dart';
import 'package:flutter_controle_frequencias/ui/management/evaluation_page.dart';
import 'package:flutter_controle_frequencias/ui/register/class_page.dart';
import 'package:flutter_controle_frequencias/ui/register/discipline_page.dart';
import 'package:flutter_controle_frequencias/ui/register/student_page.dart';
import 'package:flutter_controle_frequencias/ui/register/teacher_page.dart';
import 'package:flutter_controle_frequencias/ui/report/student_approval_page.dart';

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
                MenuCard(
                  icon: Icons.person_add,
                  title: "Alunos",
                  page: const StudentPage(),
                ),
                MenuCard(
                  icon: Icons.school,
                  title: "Professores",
                  page: const TeacherPage(),
                ),
                MenuCard(
                  icon: Icons.book,
                  title: "Disciplinas",
                  page: const DisciplinePage(),
                ),
                MenuCard(
                  icon: Icons.people,
                  title: "Turmas",
                  page: const ClassPage(),
                ),
              ],
            ),
            MenuTitle(title: "Gerenciamento"),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(
                  icon: Icons.numbers,
                  title: "Avaliação",
                  page: const EvaluationPage(),
                ),
                MenuCard(
                  icon: Icons.check,
                  title: "Frequências",
                  page: const AttendancePage(),
                )
              ],
            ),
            MenuTitle(title: "Relatórios"),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(
                  icon: Icons.checklist,
                  title: "Aprovação de alunos",
                  page: const StudentApprovalPage(),
                ),
              ],
            ),
          ],
        ));
  }
}
