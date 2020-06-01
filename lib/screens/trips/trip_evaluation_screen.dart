import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/eval_question.dart';
import 'package:time_wise_app/components/rating_scale.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/models/screen_section_data.dart';

class TripEvaluationScreen extends StatefulWidget {
  final Map arguments;

  TripEvaluationScreen(
    this.arguments, {
    Key key,
  }) : super(key: key);

  @override
  _TripEvaluationScreenState createState() => _TripEvaluationScreenState();
}

class _TripEvaluationScreenState extends State<TripEvaluationScreen> {
  var isSelectedEmpowerment = [false, false];
  var isSelectedService = [false, false];
  var isSelectedInfo = [false, false];
  var isSelectedCrowding = [false, false];
  var isSelectedSeat = [false, false];
  var isSelectedPower = [false, false];
  var isSelectedTemp = [false, false];
  var isSelectedNoise = [false, false];
  var isSelectedCleanliness = [false, false];
  var isSelectedPrivacy = [false, false];
  var isSelectedSecurity = [false, false];
  var isSelectedPassengers = [false, false];
  var isSelectedStation = [false, false];

  String notes = '';

  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: 'TRIP EXPERIENCE',
          sectionAction: SectionAction(),
          sectionContent: _tripEvalContent()),
    ];

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: TimeWiseAppBar(title: 'Trips • End')),
        body: ListView.builder(
            itemCount: sectionsData.length,
            itemBuilder: (context, index) {
              return ScreenSection(
                sectionTitle: sectionsData[index].sectionTitle,
                sectionAction: sectionsData[index].sectionAction,
                sectionContent: sectionsData[index].sectionContent,
              );
            }));
  }

  _tripEvalContent() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
//        _evalTitle()
          EvalQuestion('How was your trip?'),
          RatingScale(scaleType: 'emoji'),
          _divider(),
          EvalQuestion('What did you do?'),
          _activityPicker(),
          _divider(),
          EvalQuestion('Was your travel time worthwhile or wasted?'),
          RatingScale(
            scaleType: 'circle',
            minText: 'All time was wasted',
            maxText: 'All time was worth while',
          ),
          _divider(),
          _customEvalQuestion(),
          _experienceFactorRater(),
          _divider(),
          EvalQuestion('Could you have prepared better?'),
          RatingScale(scaleType: 'like'),
          _divider(),
          _tripNotes(),
          _divider(),
          TWFlatButton(
            inverted: false,
            context: context,
            buttonText: 'END TRIP',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _tripNotes() {
    return Container(
      child: Column(
        children: [
          EvalQuestion('What would you like to remember for this trip?'),
          SizedBox(height: 10.0,),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit, color: Colors.indigo,),
            ),
//            maxLines: 4,
            onChanged: (text) => { this.notes = text}
          ),
        ]
      ),
    );
  }

  _divider() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Divider(),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _customEvalQuestion() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: 'What made it \nworthwhile ('),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Icon(LineAwesomeIcons.thumbs_up),
            ),
          ),
          TextSpan(text: ') or wasted ('),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Icon(LineAwesomeIcons.thumbs_down),
            ),
          ),
          TextSpan(text: ')?'),
        ],
      ),
    );
  }

  Widget _experienceFactorRater() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      height: 200.0,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(children: [
            _experienceFactorRating('Ability to do what you wanted',
                LineAwesomeIcons.raised_fist, isSelectedEmpowerment),
            _experienceFactorRating('Train reliability & punctuality',
                LineAwesomeIcons.stopwatch, isSelectedService),
            _experienceFactorRating('Information availability & accuracy',
                LineAwesomeIcons.bullhorn, isSelectedInfo),
            _experienceFactorRating(
                'Crowding', LineAwesomeIcons.users, isSelectedCrowding),
            _experienceFactorRating(
                'Seat availability', LineAwesomeIcons.chair, isSelectedSeat),
            _experienceFactorRating(
                'Power supply', LineAwesomeIcons.plug, isSelectedPower),
            _experienceFactorRating('Coach temperature',
                LineAwesomeIcons.thermometer_1_2_full, isSelectedTemp),
            _experienceFactorRating(
                'Coach noise levels', LineAwesomeIcons.deaf, isSelectedNoise),
            _experienceFactorRating('Coach cleanliness', LineAwesomeIcons.broom,
                isSelectedCleanliness),
            _experienceFactorRating(
                'Privacy', LineAwesomeIcons.user_secret, isSelectedPrivacy),
            _experienceFactorRating('Security',
                LineAwesomeIcons.alternate_shield, isSelectedSecurity),
            _experienceFactorRating('Other passengers',
                LineAwesomeIcons.user_friends, isSelectedPassengers),
            _experienceFactorRating(
                'Station', LineAwesomeIcons.archway, isSelectedStation),
          ]),
        ),
      ),
    );
  }

  Widget _experienceFactorRating(
      String label, IconData icon, List<bool> isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Icon(icon, size: 30.0)),
          Expanded(
              flex: 4,
              child: Text(
                label,
                style: TextStyle(fontSize: 16.0),
              )),
          Expanded(
            flex: 2,
            child: ToggleButtons(
              color: Colors.indigo,
              fillColor: Colors.indigo,
              borderColor: Colors.indigo,
              selectedColor: Colors.white,
              selectedBorderColor: Colors.indigo,
              borderRadius: BorderRadius.circular(5.0),
              children: [
                Icon(LineAwesomeIcons.thumbs_down),
                Icon(LineAwesomeIcons.thumbs_up)
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
            ),
          ),
        ],
      ),
    );
  }

  _activityPicker() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 160.0,
      child: Scrollbar(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _activityTile('Eat or drink', LineAwesomeIcons.hamburger),
                _activityTile('Make phone calls or send messages',
                    LineAwesomeIcons.mobile_phone),
                _activityTile('Read', LineAwesomeIcons.book_open),
                _activityTile(
                    'Write or edit documents', LineAwesomeIcons.edit),
                _activityTile(
                    'Browse the Internet (social media, travel info, etc.)',
                    LineAwesomeIcons.globe),
                _activityTile('Watch videos', LineAwesomeIcons.film),
                _activityTile(
                    'Listen to music, podcasts, audio books or radio',
                    LineAwesomeIcons.headphones),
                _activityTile('Play games', LineAwesomeIcons.gamepad),
                _activityTile('Take a nap', LineAwesomeIcons.bed),
                _activityTile('Talk to other passengers',
                    LineAwesomeIcons.user_friends),
                _activityTile('Care for other passengers',
                    LineAwesomeIcons.universal_access),
              ],
            )),
      ),
    );
  }

  Widget _activityTile(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: 110.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
            color: Colors.indigo,
          ),
          SizedBox(height: 20.0),
          Flexible(
              fit: FlexFit.tight,
              child: Text(
                label,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
