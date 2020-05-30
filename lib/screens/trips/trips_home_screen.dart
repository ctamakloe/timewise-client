import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
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
                'title': 'Trips • Upcoming',
                'trips': Trip.sampleInProgressTrips
              }),
          sectionContent: TripList(trips: Trip.sampleInProgressTrips.take(2).toList())),
      ScreenSectionData(
          sectionTitle: 'PREVIOUS',
          sectionAction: SectionAction(
              title: 'Show more',
              route: '/tripsList',
              routeArguments: {
                'title': 'Trips • Previous',
                'trips': Trip.sampleCompleteTrips
              }),
          sectionContent: TripList(trips: Trip.sampleCompleteTrips.take(2).toList())),
    ];

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(title: 'Trips')),
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
