import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/screens/account/account_view.dart';
import 'package:time_wise_app/screens/login_signup_screen.dart';
import 'package:time_wise_app/screens/profile/profile_home_screen.dart';
import 'package:time_wise_app/screens/profile/profile_view.dart';
import 'package:time_wise_app/screens/trips/trips_view.dart';
import 'package:time_wise_app/state_container.dart';

enum AuthStatus {
//  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthStatus authStatus = AuthStatus.NOT_LOGGED_IN;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (StateContainer.of(context).getAppState().isLoggedIn())
      authStatus = AuthStatus.LOGGED_IN;
    else
      authStatus = AuthStatus.NOT_LOGGED_IN;

    switch (authStatus) {
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignupScreen();
        break;
      default:
        return Scaffold(
          body: SafeArea(
            top: false,
            child: _buildApp(),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.white,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//            primaryColor: Colors.red,
//            texttheme: theme.of(context)
//                .texttheme
//                .copywith(caption: new textstyle(color: colors.yellow))
      ),
      // sets the inactive color of the `BottomNavigationBar`
      child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.indigoAccent,
              title: Text('Trips', style: TextStyle(fontSize: 14.0)),
              icon: Icon(
                LineAwesomeIcons.train,
                size: 30.0,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.indigoAccent,
              title: Text('Profile', style: TextStyle(fontSize: 14.0)),
              icon: Icon(
                LineAwesomeIcons.bar_chart_1,
                size: 30.0,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.indigoAccent,
              title: Text('Account', style: TextStyle(fontSize: 14.0)),
              icon: Icon(
                LineAwesomeIcons.user_circle,
                size: 30.0,
              ),
            ),
          ]),
    );
  }

  Widget _buildApp() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        TripsView(),
        ProfileView(),
        AccountView(),
      ],
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupScreen();
        break;
      default:
        return Scaffold(
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex,
              children: allDestinations.map<Widget>((Destination destination) {
                return destination.view;
              }).toList(),
            ),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//            primaryColor: Colors.red,
//            texttheme: theme.of(context)
//                .texttheme
//                .copywith(caption: new textstyle(color: colors.yellow))
            ),
            // sets the inactive color of the `BottomNavigationBar`
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: allDestinations.map((Destination destination) {
                return BottomNavigationBarItem(
                  backgroundColor: Colors.indigoAccent,
                  title: Text(destination.linkTitle,
                      style: TextStyle(fontSize: 16.0)),
                  icon: Icon(
                    destination.icon,
                    size: 30.0,
                  ),
                );
              }).toList(),
            ),
          ),
        );
    }
  }
  */

}

class Destination {
  final String linkTitle;
  final IconData icon;
  final Widget view;

  const Destination(this.linkTitle, this.icon, this.view);
}

List<Destination> allDestinations = <Destination>[
  Destination('Trips', LineAwesomeIcons.train, TripsView()),
  Destination('Profile', LineAwesomeIcons.bar_chart, ProfileView()),
  Destination('Account', LineAwesomeIcons.user_circle, AccountView()),
];
