import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/add_checklist_screen.dart';
import 'package:time_wise_app/screens/trips/detail_sections/coverage_info_content.dart';
import 'package:time_wise_app/screens/trips/detail_sections/services_info_content.dart';
import 'package:time_wise_app/screens/trips/detail_sections/trip_check_list_content.dart';
import 'package:time_wise_app/screens/trips/detail_sections/trip_info_content.dart';
import 'package:time_wise_app/state_container.dart';

class TripDetailsScreen extends StatefulWidget {
  final Trip trip;
  final Function onTripChanged;

  TripDetailsScreen({
    Key key,
    @required this.trip,
    @required this.onTripChanged,
  }) : super(key: key);

  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
        sectionTitle: '',
        sectionAction: SectionAction(),
        sectionContent: TripInfoContent(
            trip: widget.trip, onTripChanged: widget.onTripChanged),
      ),
    ];

    sectionsData.add(ScreenSectionData(
      sectionTitle: 'AVAILABLE SERVICES',
      sectionAction: SectionAction(),
      sectionContent: ServicesInfoContent(trip: widget.trip),
    ));

    sectionsData.add(ScreenSectionData(
      sectionTitle: 'SERVICE TRACKER',
      sectionAction: SectionAction(),
      sectionContent: CoverageInfoContent(trip: widget.trip),
    ));

    sectionsData.add(ScreenSectionData(
      sectionTitle: 'TRIP CHECKLIST',
      sectionAction: SectionAction(
        type: 'modal',
        title: 'Add item',
        screen: AddChecklistScreen(),
      ),
      sectionContent: TripChecklistContent(trip: widget.trip),
    ));


    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(
              title: 'Trip • Details',
              actions: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: IconButton(
                    icon: Icon(LineAwesomeIcons.trash, size: 30.0),
                    onPressed: () {
                      widget.trip.delete(context).then((trip) {
                        StateContainer.of(context).loadTrips().then((tripId) {
                          setState(() {
                            widget.onTripChanged();
                          });
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Trip deleted')));
                          Navigator.pop(context, trip);
                        });
                      });
                    },
                  ),
                ),
              ],
            )),
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
