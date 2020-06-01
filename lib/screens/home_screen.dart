import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/screens/profile/profile_view.dart';
import 'package:time_wise_app/screens/trips/trips_view.dart';
import 'package:time_wise_app/screens/wizard/wizard_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

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
              title:
                  Text(destination.linkTitle, style: TextStyle(fontSize: 16.0)),
              icon: Icon(destination.icon,
                size: 30.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

const List<Destination> allDestinations = <Destination>[
  Destination('Trips', LineAwesomeIcons.train, TripsView()),
  Destination('Planner', LineAwesomeIcons.calendar_plus, WizardView()),
  Destination('Profile', LineAwesomeIcons.user_circle, ProfileView()),
];

class Destination {
  final String linkTitle;
  final IconData icon;
  final Widget view;

  const Destination(this.linkTitle, this.icon, this.view);
}
