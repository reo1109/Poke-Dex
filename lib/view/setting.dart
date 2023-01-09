import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Dark/Light Mode'),
          )
        ],
    );
  }
}
