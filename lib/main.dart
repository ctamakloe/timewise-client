import 'package:flutter/material.dart';
import 'package:time_wise_app/routes.dart';

void main() {
  runApp(TimeWiseApp());
}

class TimeWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimeWise',
      routes: routes,
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}




