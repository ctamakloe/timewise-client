import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/state_container.dart';

class TripsListScreen extends StatefulWidget {
  final Map arguments;

  const TripsListScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  _TripsListScreenState createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Trip> _trips = []; // currently loaded from appState;
  String _title = 'Trips';

  // serves to mainly rebuild widget using setstate
  // since it won't be rebuilt initstate
  Future<void> _refresh() async {
    if (!mounted) return null;

    setState(() {
      _trips = StateContainer.of(context).getAppState().trips;

      switch (widget.arguments['tripType']) {
        case 'upcoming':
          {
            _title = 'Trips • Upcoming';
            _trips = _trips.where((trip) => trip.isUpcoming()).toList();
          }
          break;
        case 'in-progress':
          {
            _title = 'Trips • In-Progress';
            _trips = _trips.where((trip) => trip.isInProgress()).toList();
          }
          break;
        case 'completed':
          {
            _title = 'Trips • Previous';
            _trips = _trips.where((trip) => trip.isCompleted()).toList();
          }
          break;
      }
    });
  }

  _notifyTripListScreen() {
    print('TripListScreen notified of trip change');
    // refresh current widget
    _refresh();

    // refresh previous widget (trip overview screen) as well
    widget.arguments['onTripChanged']();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: TimeWiseAppBar(title: _title, actions: []),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          children: [
            ScreenSection(
                sectionTitle: '',
                sectionAction: SectionAction(),
                sectionContent: TripList(
                  trips: _trips,
                  onTripChanged: _notifyTripListScreen,
                )),
          ],
        ),
      ),
    );
  }
}
