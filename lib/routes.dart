import 'package:flutter/material.dart';
import 'package:time_wise_app/screens/home_screen.dart';
import 'package:time_wise_app/screens/login_signup_screen.dart';
import 'package:time_wise_app/screens/trips/trips_overview_screen.dart';

final routes = {
  '/tripsHome': (BuildContext context) => TripsOverviewScreen(),
  'login': (BuildContext context) => LoginSignupScreen(),
  '/': (BuildContext context) => HomeScreen(),
};
