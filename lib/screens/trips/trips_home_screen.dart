import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_item.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionData = <ScreenSectionData>[
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
          title: Text('TRIPS',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ),
        body: ListView.builder(
            itemCount: sectionData.length,
            itemBuilder: (context, index) {
              return _buildSection(context, sectionData[index]);
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

//List<ScreenSectionData> sectionData = <ScreenSectionData>[
//  ScreenSectionData(
//      sectionTitle: 'UPCOMING TRIPS',
//      sectionAction: SectionAction('Show more', '/tripsList', {'trips': Trip.sampleTrips}),
//      sectionContent: TripListContent(Trip.sampleTrips)
//  ),
//  ScreenSectionData(
//      sectionTitle: 'PREVIOUS TRIPS',
//      sectionAction: SectionAction('Show more', '/tripsList', {'trips': Trip.sampleTrips}),
//      sectionContent: TripListContent(Trip.sampleTrips)
//  ),
//];

//class TripListContent extends StatelessWidget {
//  final List<Trip> trips;
//
//  TripListContent(this.trips);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: Column(
//      children:
//          trips.map<TripListItem>((trip) => TripListItem(trip: trip)).toList(),
//    ));
//  }
//}
