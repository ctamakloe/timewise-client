import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_item.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: 'UPCOMING TRIPS',
          sectionAction: SectionAction(
              'Show more', '/tripsList', {'trips': Trip.sampleTrips}),
          sectionContent: _tripListContent(Trip.sampleTrips)),
      ScreenSectionData(
          sectionTitle: 'PREVIOUS TRIPS',
          sectionAction: SectionAction(
              'Show more', '/tripsList', {'trips': Trip.sampleTrips}),
          sectionContent: _tripListContent(Trip.sampleTrips)),
    ];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('TimeWise',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),
        body: ListView.builder(
            itemCount: sectionsData.length,
            itemBuilder: (context, index) {
              return _buildSection(context, sectionsData[index]);
            }));
  }

  _buildSection(BuildContext context, ScreenSectionData sectionData) {
    return ScreenSection(
      sectionTitle: sectionData.sectionTitle,
      sectionAction: sectionData.sectionAction,
      sectionContent: sectionData.sectionContent,
    );
  }

  Widget _tripListContent(List<Trip> trips) {
    return Container(
        child: Column(
      children:
          trips.map<TripListItem>((trip) => TripListItem(trip: trip)).toList(),
    ));
  }
}
