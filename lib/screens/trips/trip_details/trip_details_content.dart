import 'package:flutter/material.dart';
import "package:charcode/html_entity.dart";
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_wise_app/components/detail_item.dart';
import 'package:time_wise_app/components/icon_tile.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/trip_evaluation_screen.dart';
import 'package:time_wise_app/screens/trips/trip_start_screen.dart';

class TripDetailsContent extends StatefulWidget {
  TripDetailsContent({
    Key key,
    @required this.trip,
  }) : super(key: key);

  Trip trip;

  @override
  _TripDetailsContentState createState() => _TripDetailsContentState();
}

class _TripDetailsContentState extends State<TripDetailsContent> {
  @override
  Widget build(BuildContext context) {
    Trip _trip = widget.trip;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
// origin - destination
          Column(
            children: [
              SizedBox(height: 20.0,),
              Text(
                _trip.originStationName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Image(
                    height: 12.0,
                    width: 12.0,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/arrow-down.png')),
              ),
              Text(
                _trip.destinationStationName,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
// description
          Text(_trip.purposeDescription),
          SizedBox(height: 15.0),
// schedule
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _trip.date,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 2.0,
                color: Colors.grey.shade100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _trip.schedule,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
// other details
//          Divider(thickness: 1.0, height: 40.0,),
          DetailItemText(
            detailIcon: Icons.timer,
            detailLabel: _trip.isCompleted() ? 'Duration' : 'Expected Duration',
            detailValue: '1h 50m',
          ),
          DetailItemDivider(),
          DetailItemText(
            detailIcon: _trip.isBusiness()
                ? LineAwesomeIcons.briefcase
                : LineAwesomeIcons.theater_masks,
            detailLabel: 'Trip Type',
            detailValue: _trip.type.capitalize(),
          ),
          DetailItemDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  LineAwesomeIcons.cloud_with_sun,
                  size: 25,
                ),
              ),
              Expanded(flex: 4, child: Text('Weather')),
              Expanded(
                flex: 2,
                child: Text(
                  '14 ' + String.fromCharCode($deg) + 'C',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          DetailItemDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
//                    Icons.room,
                  LineAwesomeIcons.map_pin,
                  size: 25,
                ),
              ),
              Expanded(flex: 4, child: Text('Events')),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    IconTile(
                      onTap: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            builder: (context, scrollController) {
                              return Container(
                                padding: EdgeInsets.all(30.0),
                                child: Text('Bank holiday on this day'),
                              );
                            });
                      },
                      icon: LineAwesomeIcons.calendar_with_day_focus,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    IconTile(
                      onTap: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            builder: (context, scrollController) {
                              return Container(
                                padding: EdgeInsets.all(30.0),
                                child:
                                    Text('Champions League match on this day'),
                              );
                            });
                      },
                      icon: LineAwesomeIcons.futbol_1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          DetailItemDivider(),
// start/stop trip button
          if (!_trip.isCompleted()) _statusSection(context, _trip),
        ],
      ),
    );
  }

  Column _statusSection(BuildContext context, Trip trip) {
    return Column(
      children: [
        Text(
          _tripStatusMessage(trip),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: _statusButton(context, trip)),
      ],
    );
  }

  String _tripStatusMessage(Trip trip) {
    if (trip.isUpcoming()) return 'This trip has not yet started';

    if (trip.isCompleted()) return 'This trip has ended';

    return 'This trip is currently in progress';
  }

  TWFlatButton _statusButton(BuildContext context, Trip trip) {
    return TWFlatButton(
        inverted: false,
        context: context,
        buttonText: trip.isUpcoming() ? 'START TRIP' : 'END TRIP',
        onPressed: () {
          if (trip.isUpcoming()) {
            _navigateAndDisplaySelection(
              context,
              trip,
              TripStartScreen({'trip': trip}),
            );
          } else if (trip.isInProgress()) {
            _navigateAndDisplaySelection(
              context,
              trip,
              TripEvaluationScreen({'trip': trip}),
            );
          }
        });
  }

  _navigateAndDisplaySelection(
      BuildContext context, Trip trip, Widget route) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
    if (result != null) {
      setState(() {
        trip = result;
      });
    }
  }
}
