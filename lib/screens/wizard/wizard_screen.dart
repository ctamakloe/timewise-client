import 'package:flutter/material.dart';

class WizardScreen extends StatefulWidget {
  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PLAN'),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.green,
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
