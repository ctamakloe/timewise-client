import 'package:flutter/material.dart';
import 'package:time_wise_app/screens/account/account_edit_screen.dart';
import 'package:time_wise_app/screens/account/account_home_screen.dart';
import 'package:time_wise_app/screens/profile/profile_home_screen.dart';

class AccountView extends StatefulWidget {
  AccountView({
    Key key,
  }) : super(key: key);

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
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
                return AccountHomeScreen();
              case '/accountEdit':
                return AccountEditScreen();
            }
          },
        );
      },
    );
  }
}
