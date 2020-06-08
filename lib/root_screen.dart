//import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:time_wise_app/models/auth_service.dart';
//import 'package:time_wise_app/screens/home_screen.dart';
//import 'package:time_wise_app/screens/login_signup_screen.dart';
//import 'package:time_wise_app/services/user_service.dart';
//
//enum AuthStatus {
//  NOT_DETERMINED,
//  NOT_LOGGED_IN,
//  LOGGED_IN,
//}
//
//class RootScreen extends StatefulWidget {
//  final AuthService authService;
//  final Widget destinationScreen;
//
//  RootScreen({this.authService, this.destinationScreen});
//
//  @override
//  State<StatefulWidget> createState() => new _RootScreenState();
//}
//
//class _RootScreenState extends State<RootScreen> {
//  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//
//  String _token;
//
//  @override
//  void initState() {
//    super.initState();
//    // check if a user is logged in
//    widget.authService.getAuthToken().then((token) {
//      setState(() {
//        if (token == null) {
//          authStatus = AuthStatus.NOT_LOGGED_IN;
//        } else {
//          _token = token;
//          authStatus = AuthStatus.LOGGED_IN;
//        }
//      });
//    });
//  }
//
//  // Setup for each screen
//  // => sets up the _token for use in screen and the authStatus
//  // => should be passed to each screen
//  void loginCallback() {
//    widget.authService.getAuthToken().then((token) {
//      setState(() {
//        _token = token;
//      });
//    });
//
//    setState(() {
//      authStatus = AuthStatus.LOGGED_IN;
//    });
//  }
//
//  void logoutCallback() {
//    setState(() {
//      authStatus = AuthStatus.NOT_LOGGED_IN;
//      _token = null;
//    });
//  }
//
//  Widget buildWaitingScreen() {
//    return Scaffold(
//      body: Container(
//        alignment: Alignment.center,
//        child: CircularProgressIndicator(),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    switch (authStatus) {
//      case AuthStatus.NOT_DETERMINED:
//        return buildWaitingScreen();
//        break;
//      case AuthStatus.NOT_LOGGED_IN:
//        return new LoginSignupScreen(
//          authService: widget.authService,
//          loginCallback: loginCallback,
//        );
//        break;
//      case AuthStatus.LOGGED_IN:
//        if (_token != null && _token.length > 0) {
//
//          return new HomeScreen(
//            authService: widget.authService,
//            logoutCallback: logoutCallback,
//          );
//        } else
//          return buildWaitingScreen();
//        break;
//      default:
//        return buildWaitingScreen();
//    }
//  }
//}
