//import 'package:flutter/material.dart';
//import 'package:time_wise_app/screens/trips/trip_details/trip_details_screen.dart';
//import 'package:time_wise_app/screens/wizard/wizard_screen.dart';
//
//class WizardView extends StatefulWidget {
//  const WizardView({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  _WizardViewState createState() => _WizardViewState();
//}
//
//class _WizardViewState extends State<WizardView> {
//  @override
//  Widget build(BuildContext context) {
//    return Navigator(
//      onGenerateRoute: (RouteSettings settings) {
//        final arguments = settings.arguments;
//        return MaterialPageRoute(
//          settings: settings,
//          // ignore: missing_return
//          builder: (BuildContext context) {
//            switch (settings.name) {
//              case '/':
//                return WizardScreen();
//              case '/tripDetails':
//                return TripDetailsScreen(arguments);
//            }
//          },
//        );
//      },
//    );
//  }
//}
