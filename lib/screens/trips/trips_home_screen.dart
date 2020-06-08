import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/services/auth_service.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/login_signup_screen.dart';
import 'package:time_wise_app/services/trip_service.dart';
import 'package:time_wise_app/state_container.dart';

class TripsHomeScreen extends StatefulWidget {
  @override
  _TripsHomeScreenState createState() => _TripsHomeScreenState();
}

class _TripsHomeScreenState extends State<TripsHomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Trip> _trips = []; // Trip.allTrips;
  List<Trip> _upcoming = [];
  List<Trip> _inProgress = [];
  List<Trip> _completed = [];

  Future<Null> _refresh() {
    return TripService().getTrips(context).then((trips) {
      // no locally saved trips
      if (trips != null) {
        setState(() {
          _trips = trips;
          _upcoming = _trips.where((trip) => trip.isUpcoming()).toList();
          _inProgress = _trips.where((trip) => trip.isInProgress()).toList();
          _completed = _trips.where((trip) => trip.isCompleted()).toList();
        });
//        StateContainer.of(context).setShouldRefreshTrips(false);
      }

      /* uncomment to implement saving trips locally
      // save trips from server locally
      if (trips != null) {
        setState(() {
          StateContainer.of(context).saveTrips(trips);
          print('new trips:' + trips.toString());
        });
      }
      // populate view with locally saved trips
      setState(() {
        _trips = StateContainer.of(context).getSavedTrips();

        _upcoming = _trips.where((trip) => trip.isUpcoming()).toList();
        _inProgress = _trips.where((trip) => trip.isInProgress()).toList();
        _completed = _trips.where((trip) => trip.isCompleted()).toList();
      });
      */
    });
  }

  @override
  void initState() {
    super.initState();

//    print(StateContainer.of(context).shouldRefreshTrips());
//
//    if (StateContainer.of(context).shouldRefreshTrips())
//      WidgetsBinding.instance.addPostFrameCallback(
//          (_) => _refreshIndicatorKey.currentState.show());
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {

    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      if (_trips.isEmpty)
        ScreenSectionData(
          sectionTitle: '',
          sectionAction: SectionAction(),
          sectionContent: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 100.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No trips found',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              )),
        ),
      if (_inProgress.isNotEmpty)
        ScreenSectionData(
            sectionTitle: 'IN-PROGRESS',
            sectionAction: SectionAction(),
//          sectionContent: TripListContent(trips: Trip.sampleUpcomingTrips)),
            sectionContent: TripListContent(trips: _inProgress)),
      if (_upcoming.isNotEmpty)
        ScreenSectionData(
            sectionTitle: 'UPCOMING',
            sectionAction: SectionAction(
                title: 'Show more',
                route: '/tripsList',
                routeArguments: {
                  'title': 'Trips • Upcoming',
                  'trips': _upcoming,
                }),
//          sectionContent: TripListContent(trips: Trip.sampleInProgressTrips.take(2).toList())),
            sectionContent: TripListContent(trips: _upcoming.take(3).toList())),
      if (_completed.isNotEmpty)
        ScreenSectionData(
            sectionTitle: 'PREVIOUS',
            sectionAction: SectionAction(
                title: 'Show more',
                route: '/tripsList',
                routeArguments: {
                  'title': 'Trips • Previous',
                  'trips': _completed,
                }),
//          sectionContent: TripListContent(
//              trips: Trip.sampleCompleteTrips.take(2).toList())),
            sectionContent:
                TripListContent(trips: _completed.take(3).toList())),
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: TimeWiseAppBar(title: 'Trips', actions: [
            // action button
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                icon: Icon(LineAwesomeIcons.calendar_plus, size: 30.0,),
                onPressed: () {
                  Navigator.pushNamed(context, '/tripPlanner');
                },
              ),
            ),
          ])),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: sectionsData.length,
              itemBuilder: (context, index) {
                return ScreenSection(
                  sectionTitle: sectionsData[index].sectionTitle,
                  sectionAction: sectionsData[index].sectionAction,
                  sectionContent: sectionsData[index].sectionContent,
                );
              })),
    );
  }
}
