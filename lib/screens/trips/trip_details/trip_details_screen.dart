import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/trip_details/coverage_info_content.dart';
import 'package:time_wise_app/screens/trips/trip_details/services_info_content.dart';
import 'package:time_wise_app/screens/trips/trip_details/trip_check_list_content.dart';
import 'package:time_wise_app/screens/trips/trip_details/trip_details_content.dart';

class TripDetailsScreen extends StatefulWidget {
  final Trip trip;

  TripDetailsScreen(
    this.trip, {
    Key key,
  }) : super(key: key);

  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
        sectionTitle: 'TRIP DETAILS',
        sectionAction: SectionAction(),
        sectionContent: TripDetailsContent(trip: widget.trip),
      ),
    ];

    if (widget.trip.status != 'complete') {
      sectionsData.add(ScreenSectionData(
        sectionTitle: 'AVAILABLE SERVICES',
        sectionAction: SectionAction(),
        sectionContent: ServicesInfoContent(trip: widget.trip),
      ));

      sectionsData.add(ScreenSectionData(
        sectionTitle: 'SIGNAL COVERAGE',
        sectionAction: SectionAction(),
        sectionContent: CoverageInfoContent(trip: widget.trip),
      ));

      sectionsData.add(ScreenSectionData(
          sectionTitle: 'PREVIOUS TRIPS',
          sectionAction: SectionAction(
              title: 'Show more',
              route: '/tripsList',
              routeArguments: {
                'title': 'Previous Trips',
                'trips': Trip.sampleCompleteTrips
              }),
          sectionContent:
              TripList(trips: Trip.sampleCompleteTrips.take(2).toList())));

      sectionsData.add(ScreenSectionData(
        sectionTitle: 'TRIP CHECKLIST',
        sectionAction: SectionAction(),
        sectionContent: TripChecklistContent(trip: widget.trip),
      ));
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(title: 'Trips • Details')),
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
}
