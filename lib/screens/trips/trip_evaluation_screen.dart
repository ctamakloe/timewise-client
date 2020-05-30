import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/station.dart';
import 'package:time_wise_app/models/trip.dart';

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

  @override
  Widget build(BuildContext context) {
    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: 'TRIP EXPERIENCE',
          sectionAction: SectionAction(),
          sectionContent: _tripEvalContent()),
    ];

    return Scaffold(
        appBar: AppBar(
          title: AppBarTitle(title: 'End Trip'),
        ),
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
          _evalQuestion('How was your trip?'),
          _ratingScale('emoji'),
          SizedBox(height: 10.0),
          Divider(),
          SizedBox(height: 10.0),
          _evalQuestion('What did you do?'),
          _activityPicker(),
          SizedBox(height: 10.0),
          Divider(),
          SizedBox(height: 10.0),
          _evalQuestion('Was your travel time worthwhile or wasted?'),
          _ratingScale('star'),
          SizedBox(height: 10.0),
          Divider(),
          SizedBox(height: 10.0),
          _evalQuestionCustom(),
          _experienceFactorRater(),
          SizedBox(height: 10.0),
          Divider(),
          SizedBox(height: 10.0),
          _evalQuestion('Could you have prepared better?'),
          _ratingScale('like'),
          SizedBox(height: 10.0),
          Divider(),
          Container(
            width: double.infinity,
            child: FlatButton(
              color: Colors.indigo[300],
              textColor: Colors.white,
              child: Text(
                'END TRIP',
                style: TextStyle(),
              ),
              onPressed: () => print('saved'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _evalQuestion(String questionText) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        questionText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _evalQuestionCustom() {
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

  Widget _ratingScale(String type) {
    List<IconData> icons = [];

    if (type == 'emoji') {
      icons = [
        LineAwesomeIcons.loudly_crying_face,
        LineAwesomeIcons.frowning_face,
        LineAwesomeIcons.neutral_face,
        LineAwesomeIcons.smiling_face,
        LineAwesomeIcons.grinning_face_with_smiling_eyes,
      ];
    }
    if (type == 'star') {
      icons = [
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
        LineAwesomeIcons.star,
      ];
    }
    if (type == 'like') {
      icons = [
        LineAwesomeIcons.thumbs_down,
        LineAwesomeIcons.thumbs_up,
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: icons
          .asMap()
          .map((index, icon) =>
              MapEntry(index, _ratingIcon(index, icon, index == icons.length)))
          .values
          .toList(),
    );
  }

  Widget _ratingIcon(int index, IconData icon, bool lastIcon) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              size: 40.0,
              color: Colors.indigo,
            ),
          ),
          if (lastIcon) Spacer(),
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
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _activityTile('Eat or drink', LineAwesomeIcons.hamburger),
                  _activityTile(
                      'Make phone calls or send messages', LineAwesomeIcons.mobile_phone),
                  _activityTile('Read', LineAwesomeIcons.book_open),
                  _activityTile(
                      'Write or edit documents', LineAwesomeIcons.edit),
                  _activityTile(
                      'Browse the Internet (social media, travel info, etc.)',
                      LineAwesomeIcons.internet_explorer),
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
              ),
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
