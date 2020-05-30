import 'package:flutter/material.dart';
import 'package:time_wise_app/screens/home_screen.dart';
import 'package:time_wise_app/screens/login_screen.dart';
import 'package:time_wise_app/screens/profile/profile_screen.dart';
import 'package:time_wise_app/screens/sign_up_screen.dart';
import 'package:time_wise_app/screens/trips/trips_home_screen.dart';

final routes = {
//  '/tripDetails': (BuildContext context) => TripDetailsScreen(),
//  '/tripsList': (BuildContext context) => TripsListScreen(),
  '/tripsHome': (BuildContext context) => TripsHomeScreen(),

  '/profile': (BuildContext context) => ProfileScreen(),

  '/signup': (BuildContext context) => SignUpScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/': (BuildContext context) => HomeScreen(),
};
