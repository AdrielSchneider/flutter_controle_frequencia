import 'package:flutter/material.dart';
import 'package:flutter_controle_frequencias/ui/home_page.dart';

class MenuCard extends StatelessWidget {
  MenuCard({Key? key, required this.icon, required this.title, required this.onTapFunc}) : super(key: key);

  IconData icon;
  String title;
  Function onTapFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Expanded(child: Icon(icon)), Center(child: Text(title),)],
          )
      ),
      onTap: onTapFunc(),
    );
  }
}
