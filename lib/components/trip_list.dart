import 'package:flutter/material.dart';
import 'package:time_wise_app/components/trip_item.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  const TripList({
    Key key,
    this.trips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: '',
          sectionAction: SectionAction(),
          sectionContent: TripList(trips: trips)),
    ];
    return Container(
        child: Column(
      children: this
          .trips
          .map<TripListItem>((trip) => TripListItem(trip: trip))
          .toList(),
    ));
  }
}
