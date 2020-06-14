import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_wise_app/models/station.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/models/user.dart';
import 'package:time_wise_app/services/trip_service.dart';

class AppState {
  String token;
  User user;
  String environment;
  List<Station> stations;
  List<Trip> trips;

  bool isLoggedIn() => token != null;

  AppState({this.token, this.trips});
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final AppState appState;

  StateContainer({
    @required this.child,
    this.appState,
  });

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
//    return (context.dependOnInheritedWidgetOfExactType()
//    as _InheritedStateContainer)
//        .data;
  }

  @override
  StateContainerState createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  AppState appState;

  getAppState() {
    // happens on login/signup screen
    if (appState == null) {
      appState = AppState(
        token: null,
//        trips: [],
      );
    }
    return appState;
  }

  login(User user) {
    // set token in sharedprefs
    SharedPrefs.saveAuthToken(user.authToken);

    // update app state
    appState = getAppState();

    // set session vars
    appState.user = user;
    appState.token = user.authToken;

    // get stations
    loadStations().then(((stations) {
      setState(() {
        appState.stations = stations;
        print('loadStations complete');
      });
    }));

    // load trips from server into state
    loadTrips();

    /*
    TripService().getTrips(getApiUrl(), appState.token).then((trips) {
      if (trips != null) {
        setState(() {
          trips.sort((a, b) => b.departsAt.compareTo(a.departsAt));
          appState.trips = trips;
          print('getTrips (server) ran');
        });
      }
    });
     */
  }

  // Retrieve trips from server and store locally
  Future<List<Trip>> loadTrips() async {
    await TripService().getTrips(getApiUrl(), appState.token).then((trips) {
      if (trips != null) {
        setState(() {
          trips.sort((a, b) => b.departsAt.compareTo(a.departsAt));
          appState.trips = trips;
          print('loadTrips (server) complete');
        });
      }
      return trips;
    });
  }

  logout() {
    // remove from sharedprefs
    SharedPrefs.clearAuthToken();
    // update app state
    appState = getAppState();
    setState(() {
      appState.token = null;
      appState.user = null;
      appState.trips = [];
      appState.stations = [];
    });
  }

  isLoggedIn() {
    return appState.isLoggedIn();
  }

  setAppEnvironment(String environment) {
    appState = getAppState();
    setState(() {
      appState.environment = environment;
    });
  }

  getAppEnvironment() {
    appState = getAppState();
    if (appState.environment == null) appState.environment = 'development';
    return appState.environment;
  }

  String getApiUrl() {
    var environment = getAppEnvironment();

    switch (environment) {
      case 'production':
        return 'https://timewiseapi.herokuapp.com';
        break;
      case 'development':
        return 'http://localhost:3000';
    }
  }

  static Future<List<Station>> loadStations() async {
    List<Station> list = [];

    await rootBundle.loadString('assets/res/station_codes.csv').then((value) {
      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(value);
      rowsAsListOfValues.forEach((row) {
        list.add(Station(code: row[1], name: row[0]));
      });
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class SharedPrefs {
  static clearAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? null;
  }

  static saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
