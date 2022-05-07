import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  MenuTitle({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Title(color: Colors.black, child: Padding(padding: const EdgeInsets.only(top: 10.0, bottom: 10.0), child: Text(title)));
  }
}
