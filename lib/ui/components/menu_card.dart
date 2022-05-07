import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  MenuCard({Key? key, required this.icon, required this.title}) : super(key: key);

  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Expanded(child: Icon(icon)), Center(child: Text(title),)],
      )
    );
  }
}
