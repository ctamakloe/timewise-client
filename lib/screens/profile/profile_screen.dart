import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROFILE'),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.red,
        body: SizedBox(
          child: InkWell(
            onTap: () {
//              Navigator.pushNamed(context, "/list");
              Navigator.pop(context);
            },
          ),
        ));
  }
}
