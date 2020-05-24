import 'package:flutter/material.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

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
    List<ScreenSectionData> sectionData = <ScreenSectionData>[
      ScreenSectionData(
        sectionTitle: 'TRIP DETAILS',
        sectionAction: SectionAction(
            'Edit trip', '/tripsList', {'trips': Trip.sampleTrips}),
        sectionContent: _tripInfoContent(),
      ),
      ScreenSectionData(
          sectionTitle: 'TRAIN RESOURCES',
          sectionAction: SectionAction('', '', {}),
          sectionContent: _trainResourcesContent()),
      ScreenSectionData(
          sectionTitle: 'COVERAGE CHECKER',
          sectionAction: SectionAction('', '', {}),
          sectionContent: _coverageCheckerContent()),
    ];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('TRIPS DETAILS',
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

  Widget _tripInfoContent() {
    return Container(child: Text('trip info'));
  }

  Widget _trainResourcesContent() {
    return Container(child: Text('train resources'));
  }

  Widget _coverageCheckerContent() {
    return Container(child: Text('coverage checker'));
  }
}
