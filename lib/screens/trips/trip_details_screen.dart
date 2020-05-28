import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/sections/coverage_info.dart';

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
//      ScreenSectionData(
//        sectionTitle: 'TRIP DETAILS',
//        sectionAction: SectionAction('', '', {}),
//        sectionContent: TripInfo(trip: widget.trip),
//      ),
//      ScreenSectionData(
//          sectionTitle: 'AVAILABLE SERVICES',
//          sectionAction: SectionAction('', '', {}),
//          sectionContent: ServicesInfo(trip: widget.trip),
      ScreenSectionData(
        sectionTitle: 'COVERAGE CHECKER',
        sectionAction: SectionAction('', '', {}),
        sectionContent: CoverageInfo(trip: widget.trip),
      ),
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
}
