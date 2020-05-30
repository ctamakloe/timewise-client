import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/trip_list.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
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
//      ScreenSectionData(
//        sectionTitle: 'AVAILABLE SERVICES',
//        sectionAction: SectionAction(),
//        sectionContent: ServicesInfoContent(trip: widget.trip),
//      ),
//      ScreenSectionData(
//        sectionTitle: 'SIGNAL COVERAGE',
//        sectionAction: SectionAction(),
//        sectionContent: CoverageInfoContent(trip: widget.trip),
//      ),
//      ScreenSectionData(
//          sectionTitle: 'PREVIOUS TRIPS',
//          sectionAction: SectionAction(
//              title: 'Show more',
//              route: '/tripsList',
//              routeArguments: {
//                'title': 'Previous Trips',
//                'trips': Trip.sampleTrips
//              }),
//          sectionContent: TripList(trips: Trip.sampleTrips)),
//      ScreenSectionData(
//        sectionTitle: 'TRIP CHECKLIST',
//        sectionAction: SectionAction(),
//        sectionContent: TripChecklistContent(trip: widget.trip),
//      ),
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
