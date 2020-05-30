import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripsListScreen extends StatefulWidget {
  final Map arguments; // using arguments cos i need the title for the screen as well

  const TripsListScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  _TripsListScreenState createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: widget.arguments['title']),
      ),
      body: ScreenSection(
          sectionTitle: '',
          sectionAction: SectionAction(),
          sectionContent: TripList(trips: widget.arguments['trips'])),
    );
  }
}
