import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(this.title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
  }
}
