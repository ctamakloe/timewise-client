import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/screens/wizard/trip_planner_screen.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/services/trip_service.dart';
import 'package:time_wise_app/state_container.dart';

class TripsOverviewScreen extends StatefulWidget {
  @override
  _TripsOverviewScreenState createState() => _TripsOverviewScreenState();
}

class _TripsOverviewScreenState extends State<TripsOverviewScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Trip> _trips = []; // Trip.allTrips;
  List<Trip> _upcoming = [];
  List<Trip> _inProgress = [];
  List<Trip> _completed = [];

  Future<void> _refresh() async {
    // to prevent method running after dispose()
    if (!mounted) return null;

    // trigger rebuild of widget if function called
    setState(() {
      _trips = StateContainer.of(context).getAppState().trips;
      _trips.sort((a, b) => b.departsAt.compareTo(a.departsAt));
      _upcoming = _trips.where((trip) => trip.isUpcoming()).toList();
      _inProgress = _trips.where((trip) => trip.isInProgress()).toList();
      _completed = _trips.where((trip) => trip.isCompleted()).toList();
    });
  }

  _notifyTripsOverviewScreen() {
    print(
        'Overview screen notified of trip change');
    // do nothing, since screen is always loading from memory
    // actually, not true, call setstate
    _refresh();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
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
            sectionContent: TripList(
              trips: _inProgress,
              onTripChanged: _notifyTripsOverviewScreen,
            )),
      if (_upcoming.isNotEmpty)
        ScreenSectionData(
            sectionTitle: 'UPCOMING',
            sectionAction: SectionAction(
                title: 'Show more',
                route: '/tripsList',
                routeArguments: {
                  'tripType': 'upcoming',
                  'onTripChanged': _notifyTripsOverviewScreen,
                }),
            sectionContent: TripList(
              trips: _upcoming.take(3).toList(),
              onTripChanged: _notifyTripsOverviewScreen,
            )),
      if (_completed.isNotEmpty)
        ScreenSectionData(
            sectionTitle: 'PREVIOUS',
            sectionAction: SectionAction(
                title: 'Show more',
                route: '/tripsList',
                routeArguments: {
                  'tripType': 'completed',
                  'onTripChanged': _notifyTripsOverviewScreen,
                }),
            sectionContent: TripList(
              trips: _completed.take(3).toList(),
              onTripChanged: _notifyTripsOverviewScreen,
            )),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: TimeWiseAppBar(title: 'Trips', actions: [
            // action button
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                icon: Icon(LineAwesomeIcons.calendar_plus, size: 30.0),
                onPressed: () {
//                  Navigator.pushNamed(context, '/tripPlanner');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripPlannerScreen(
                            onTripCreated: () => _notifyTripsOverviewScreen())),
                  );
                },
              ),
            ),
          ]
          )),
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
