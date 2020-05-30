import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: 'IN-PROGRESS',
          sectionAction: SectionAction(),
          sectionContent: TripList(trips: Trip.sampleUpcomingTrips)),
      ScreenSectionData(
          sectionTitle: 'UPCOMING',
          sectionAction: SectionAction(
              title: 'Show more',
              route: '/tripsList',
              routeArguments: {
                'title': 'Upcoming Trips',
                'trips': Trip.sampleInProgressTrips
              }),
          sectionContent: TripList(trips: Trip.sampleInProgressTrips)),
      ScreenSectionData(
          sectionTitle: 'PREVIOUS',
          sectionAction: SectionAction(
              title: 'Show more',
              route: '/tripsList',
              routeArguments: {
                'title': 'Previous Trips',
                'trips': Trip.sampleCompleteTrips
              }),
          sectionContent: TripList(trips: Trip.sampleCompleteTrips)),
    ];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Trips',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),
        body: ListView.builder(
            itemCount: sectionsData.length,
            itemBuilder: (context, index) {
              return ScreenSection(
                sectionTitle: sectionsData[index].sectionTitle,
                sectionAction: sectionsData[index].sectionAction,
                sectionContent: sectionsData[index].sectionContent,
              );
            }));
  }
}
