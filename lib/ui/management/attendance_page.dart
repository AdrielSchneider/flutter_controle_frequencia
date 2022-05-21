import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/datasources/local/student_helper.dart';
import 'package:flutter_controle_frequencias/model/student.dart';
import 'package:flutter_controle_frequencias/ui/components/menu_title.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key, required this.teamId}) : super(key: key);

  int teamId;

  @override
  State<AttendancePage> createState() => AttendancePageState();
}

class AttendancePageState extends State<AttendancePage> {
  final StudentHelper _studentHelper = StudentHelper();
  Map<int, bool> mapChecked = {};
  DateTime? selectedDate;

  TextEditingController _selectedDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lançamento de presença'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _studentHelper.findByTeamId(widget.teamId),
        builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: MenuTitle(
                              title: "Selecione a data", fontSize: 24.0)),
                      Expanded(
                          flex: 1,
                          child: TextField(
                              keyboardType: TextInputType.none,
                              controller: _selectedDateController,
                              onTap: _selectDate))
                    ],
                  ),
                ),
                MenuTitle(title: 'Selecione os alunos presentes'),
                ListView.builder(

                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      mapChecked.putIfAbsent(snapshot.data![index].registerNumber!, () => true,);
                      print(mapChecked[snapshot.data![index].registerNumber!]);
                      return CheckboxListTile(
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) {
                          setState(() {
                            mapChecked[snapshot.data![index].registerNumber!] = value!;
                          });
                        },
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(snapshot.data![index].name,
                            style: const TextStyle(fontSize: 28)),
                        value: mapChecked[snapshot.data![index].registerNumber!],

                      );
                    })
              ]),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _selectDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: (selectedDate ?? DateTime.now()),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        if (selectedDate != null) {
          _selectedDateController.text =
              '${(selectedDate!.day <= 9 ? '0' : '') + selectedDate!.day.toString()}/${(selectedDate!.month <= 9 ? '0' : '') + selectedDate!.month.toString()}/${selectedDate!.year}';
        } else {
          _selectedDateController.text = '';
        }
      });
    }
  }
}
