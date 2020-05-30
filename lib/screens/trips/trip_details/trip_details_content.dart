import 'package:flutter/material.dart';
import "package:charcode/html_entity.dart";
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:time_wise_app/components/icon_tile.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/trip_evaluation_screen.dart';
import 'package:time_wise_app/screens/trips/trip_start_screen.dart';

class TripDetailsContent extends StatelessWidget {
  const TripDetailsContent({
    Key key,
    @required this.trip,
  }) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
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
              Text(
                this.trip.origin,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Image(
                    height: 12.0,
                    width: 12.0,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/arrow-down.png')),
              ),
              Text(
                this.trip.destination,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
// description
          Text('RTN: ' + this.trip.description),
          SizedBox(height: 15.0),
// schedule
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mon, 25 May',
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
                      this.trip.schedule,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
// other details
//          Divider(thickness: 1.0, height: 40.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1, child: Icon(Icons.timer, size: 25)),
              Expanded(
                flex: 4,
                child: Text(this.trip.status == 'complete'
                    ? 'Duration'
                    : 'Expected Duration'),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '1h 50m',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  this.trip.purpose == 'leisure'
                      ? LineAwesomeIcons.theater_masks
                      : LineAwesomeIcons.briefcase,
                  size: 25,
                ),
              ),
              Expanded(flex: 4, child: Text('Trip Purpose')),
              Expanded(
                flex: 2,
                child: Text(
                  this.trip.purpose.capitalize(),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
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
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
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
          Divider(
            thickness: 1.0,
            height: 40.0,
          ),
// start/stop trip button
          if (this.trip.status != 'complete') _statusSection(context),
        ],
      ),
    );
  }

  Column _statusSection(BuildContext context) {
    return Column(
      children: [
        Text(
          _tripStatusMessage(this.trip.status),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: _statusButton(context)),
      ],
    );
  }

  String _tripStatusMessage(String status) {
    switch (status) {
      case 'upcoming':
        return 'This trip has not yet started';
        break;
      case 'complete':
        return 'This trip has ended';
        break;
      default:
        return 'This trip is currently in progress';
    }
  }

  TWFlatButton _statusButton(BuildContext context) {
    return TWFlatButton(
        context: context,
        buttonText: this.trip.status == 'upcoming' ? 'START TRIP' : 'END TRIP',
        onPressed: () {
          switch (this.trip.status) {
            // START TRIP
            case 'upcoming':
              {
                // TODO: set trip to in-progress on server
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context, scrollController) =>
                      TripStartScreen({'trip': this.trip}),
                );
              }
              break;
            // END TRIP
            case 'in-progress':
              {
                // TODO: set trip to started on server
                // navigate to trip evaluation screen
//                Navigator.pushNamed(context, '/tripEval',
//                    arguments: {'trip': this.trip});
//                showBarModalBottomSheet(
//                    context: context,
//                    builder:
//                );
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context, scrollController) =>
                      TripEvaluationScreen({'trip': this.trip}),
                );
              }
              break;
            default:
              {}
              break;
          }
        });
  }
}
