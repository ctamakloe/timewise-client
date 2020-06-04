import 'package:flutter/material.dart';

class TimeWiseAppBar extends StatelessWidget {
  const TimeWiseAppBar({
    Key key,
    @required this.title,
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(this.title,
          style: TextStyle(
            fontSize: 20.0,
          )),
      actions: actions,
    );
  }
}
