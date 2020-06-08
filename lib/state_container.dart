import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/models/user.dart';

class AppState {
  String token;
  User user;

//  bool refreshTrips;

//  String devAPIURL = 'http://localhost:3000';
//  String apiUrl = 'http://timewiseapi.herokuapp.com';
  String environment;

  bool isLoggedIn() => token != null;

//  List<Trip> savedTrips;
//  List<Trip> get getSavedTrips => savedTrips ?? [];
//  bool get getRefreshTrips => refreshTrips ?? true;

  AppState({this.token});
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
    if (appState == null) {
      appState = AppState(
        token: null,
      );
    }
    return appState;
  }

  void login(User user) {
    // set token in sharedprefs
    SharedPrefs.saveAuthToken(user.authToken);

    // update app state
    appState = getAppState();
    setState(() {
      if (user != null) appState.user = user;
      appState.token = user.authToken;
    });
  }

  logout() {
    // remove from sharedprefs
    SharedPrefs.clearAuthToken();
    // update app state
    appState = getAppState();
    setState(() {
      appState.token = null;
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
        return 'http://timewiseapi.herokuapp.com';
        break;
      case 'development':
        return 'http://localhost:3000';
    }
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
