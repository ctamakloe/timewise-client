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
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      bottom: PreferredSize(child: Container(color: Colors.grey[300], height: 1)),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(this.title,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          )),
      actions: actions,
    );
  }
}
