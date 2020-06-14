import 'package:flutter/material.dart';
import 'package:time_wise_app/components/trip_item.dart';
import 'package:time_wise_app/models/trip.dart';

class TripList extends StatefulWidget {
  final Function() onTripChanged;
  final List<Trip> trips;

  const TripList({
    Key key,
    @required this.trips,
    @required this.onTripChanged,
  }) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: this
          .widget
          .trips
          .map<TripListItem>((trip) => TripListItem(
                trip: trip,
                onTripChanged: widget.onTripChanged,
              ))
          .toList(),
    ));
  }
}
