import 'package:flutter/material.dart';
import 'package:time_wise_app/models/trip.dart';

class TripsListScreen extends StatefulWidget {
  final Map arguments;

  const TripsListScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  _TripsListScreenState createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TimeWise',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo,
        ),
        body: SizedBox(
          child: Text(widget.arguments['trips'][1].title),
        ));
  }
}
