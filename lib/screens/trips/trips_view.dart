import 'package:flutter/material.dart';
import 'package:time_wise_app/screens/trips/trip_details/trip_details_screen.dart';
import 'package:time_wise_app/screens/trips/trip_evaluation_screen.dart';
import 'package:time_wise_app/screens/trips/trip_start_screen.dart';
import 'package:time_wise_app/screens/trips/trips_home_screen.dart';
import 'package:time_wise_app/screens/trips/trips_list_screen.dart';
import 'package:time_wise_app/screens/wizard/wizard_screen.dart';

class TripsView extends StatefulWidget {
  const TripsView({
    Key key,
    String startRoute,
  })  : startRoute = startRoute,
        super(key: key);

  final String startRoute;

  @override
  _TripsViewState createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        final arguments = settings.arguments;

        return MaterialPageRoute(
          settings: settings,
          // ignore: missing_return
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                if (widget.startRoute == 'tripPlanner') return WizardScreen();
                return TripsHomeScreen();
              case '/tripsHome':
                return TripsHomeScreen();
              case '/tripsList':
                return TripsListScreen(arguments);
              case '/tripDetails':
                return TripDetailsScreen(arguments);
              case '/tripStart':
                return TripStartScreen(arguments);
              case '/tripEval':
                return TripEvaluationScreen(arguments);
              case '/tripPlanner':
                return WizardScreen();
            }
          },
        );
      },
    );
  }
}
