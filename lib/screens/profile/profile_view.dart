import 'package:flutter/material.dart';
import 'package:time_wise_app/screens/profile/account_edit_screen.dart';
import 'package:time_wise_app/screens/profile/profile_home_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key key,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          // ignore: missing_return
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return ProfileHomeScreen();
              case '/accountEdit':
                return AccountEditScreen();
            }
          },
        );
      },
    );
  }
}
