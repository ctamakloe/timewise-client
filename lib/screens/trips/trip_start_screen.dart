import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/eval_question.dart';
import 'package:time_wise_app/components/rating_scale.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';
import 'package:time_wise_app/screens/trips/trip_details/trip_details_screen.dart';
import 'package:time_wise_app/state_container.dart';

class TripStartScreen extends StatefulWidget {
  final Map arguments;

  TripStartScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  _TripStartScreenState createState() => _TripStartScreenState();
}

class _TripStartScreenState extends State<TripStartScreen> {
  Trip trip;

  @override
  Widget build(BuildContext context) {
    this.trip = widget.arguments['trip'];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: TimeWiseAppBar(title: 'Trips • Start')),
      body: ScreenSection(
        sectionTitle: '',
        sectionAction: SectionAction(),
        sectionContent: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EvalQuestion('How well are you prepared for this trip?'),
                SizedBox(
                  height: 20.0,
                ),
                RatingScale(
                  scaleType: 'circle',
                  minText: 'Not very well prepared',
                  maxText: 'Very well prepared',
                ),
                SizedBox(
                  height: 20.0,
                ),
                TWFlatButton(
                    inverted: false,
                    context: context,
                    buttonText: 'START TRIP',
                    onPressed: () {
                      setState(() {
                        trip.status = 'in-progress';
                        trip.save(context).then((trip) {
//                          StateContainer.of(context).setShouldRefreshTrips(true);

                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Trip started')));
                          Navigator.pop(context, trip);
                        });
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
