import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  MenuCard({Key? key, required this.icon, required this.title, required this.page}) : super(key: key);

  IconData icon;
  String title;
  Widget page;

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
      onTap: () => _openPage(context),
    );
  }

  void _openPage(context) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => page
    ));
  }
}
