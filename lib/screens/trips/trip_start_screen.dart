import 'package:flutter/material.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/eval_question.dart';
import 'package:time_wise_app/components/rating_scale.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/models/screen_section_data.dart';

class TripStartScreen extends StatelessWidget {
  final Map arguments;

  TripStartScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 20.0,),
                RatingScale(
                  scaleType: 'circle',
                  minText: 'Not very well prepared',
                  maxText: 'Very well prepared',
                ),
                SizedBox(height: 20.0,),
                TWFlatButton(
                  inverted: false,
                  context: context,
                  buttonText: 'START TRIP',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
