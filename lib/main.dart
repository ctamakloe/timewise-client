import 'package:flutter/material.dart';
import 'package:time_wise_app/routes.dart';
import 'package:time_wise_app/screens/home_screen.dart';
import 'package:time_wise_app/state_container.dart';

void main() {
//  runApp(TimeWiseApp());
  runApp(StateContainer(
    child: TimeWiseApp(),
  ));
}

class TimeWiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showBanner =
        StateContainer.of(context).getAppEnvironment() == 'development';

    return MaterialApp(
      debugShowCheckedModeBanner: showBanner,
      title: 'TimeWise',
//      routes: routes, // check here for start
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
