import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/eval_question.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/components/tw_radiobutton_question.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/models/trip.dart';

class TripEvaluationScreen extends StatefulWidget {
  final Map arguments;
  final Trip trip;

  TripEvaluationScreen(
    this.arguments, {
    Key key,
  })  : trip = arguments['trip'],
        super(key: key);

  @override
  _TripEvaluationScreenState createState() => _TripEvaluationScreenState();
}

class _TripEvaluationScreenState extends State<TripEvaluationScreen> {
  int _selectedTimeWorth = -1;
  int _selectedPrepLevel = -1;
  List<bool> _isSelectedTripExperience = List.generate(5, (_) => false);
  List<bool> _isSelectedActivities = List.generate(12, (_) => false);

  List<bool> isSelectedWithTimeWise = [false, false];
  List<bool> isSelectedWithoutTimeWise = [false, false];
  List<bool> isSelectedAbilityToDo = [false, false];
  List<bool> isSelectedService = [false, false];
  List<bool> isSelectedInfo = [false, false];
  List<bool> isSelectedCrowding = [false, false];
  List<bool> isSelectedSeat = [false, false];
  List<bool> isSelectedPower = [false, false];
  List<bool> isSelectedTemp = [false, false];
  List<bool> isSelectedNoise = [false, false];
  List<bool> isSelectedCleanliness = [false, false];
  List<bool> isSelectedPrivacy = [false, false];
  List<bool> isSelectedSecurity = [false, false];
  List<bool> isSelectedPassengers = [false, false];
  List<bool> isSelectedStation = [false, false];

  String notes = '';

  @override
  Widget build(BuildContext context) {
    Trip _trip = widget.trip;

    List<ScreenSectionData> sectionsData = <ScreenSectionData>[
      ScreenSectionData(
          sectionTitle: 'TRIP EXPERIENCE',
          sectionAction: SectionAction(),
          sectionContent: _tripEvalContent(_trip)),
    ];

    return Scaffold(
        backgroundColor: Colors.grey[100],
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

  Widget _newRatingScale() {
//    print(_isSelectedTripExperience);
//    print(_isSelectedTripExperience.indexWhere((element) => element == true));

    return ToggleButtons(
      children: <Widget>[
        Icon(LineAwesomeIcons.loudly_crying_face, size: 40.0),
        Icon(LineAwesomeIcons.frowning_face, size: 40.0),
        Icon(LineAwesomeIcons.neutral_face, size: 40.0),
        Icon(LineAwesomeIcons.smiling_face, size: 40.0),
        Icon(LineAwesomeIcons.grinning_face_with_smiling_eyes, size: 40.0),
      ],
      selectedColor: Colors.white,
      fillColor: Colors.indigo[300],
      borderColor: Colors.transparent,
      selectedBorderColor: Colors.transparent,
      isSelected: _isSelectedTripExperience,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _isSelectedTripExperience.length;
              buttonIndex++) {
            if (buttonIndex == index)
              _isSelectedTripExperience[buttonIndex] = true;
            else
              _isSelectedTripExperience[buttonIndex] = false;
          }
        });
      },
    );
  }

  Widget _activityPicker() {
//    print(_isSelectedActivities);
//    print(_isSelectedActivities.indexWhere((element) => element == true));

    return Container(
      height: 170.0,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleButtons(
            children: <Widget>[
              _activityTile('Eat or drink', LineAwesomeIcons.hamburger),
              _activityTile('Make phone calls or send messages',
                  LineAwesomeIcons.mobile_phone),
              _activityTile('Read', LineAwesomeIcons.book_open),
              _activityTile('Write or edit documents', LineAwesomeIcons.edit),
              _activityTile(
                  'Browse the Internet (social media, travel info, etc.)',
                  LineAwesomeIcons.globe),
              _activityTile('Watch videos', LineAwesomeIcons.film),
              _activityTile('Listen to music, podcasts, audio books or radio',
                  LineAwesomeIcons.headphones),
              _activityTile('Play games', LineAwesomeIcons.gamepad),
              _activityTile('Take a nap', LineAwesomeIcons.bed),
              _activityTile(
                  'Talk to other passengers', LineAwesomeIcons.user_friends),
              _activityTile('Care for other passengers',
                  LineAwesomeIcons.universal_access),
              _activityTile('Other', LineAwesomeIcons.question_circle),
            ],
            borderWidth: 5.0,
            selectedColor: Colors.white,
            fillColor: Colors.indigo[300],
            borderColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            isSelected: _isSelectedActivities,
            onPressed: (int index) {
              setState(() {
                _isSelectedActivities[index] = !_isSelectedActivities[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _tripEvalContent(Trip trip) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          EvalQuestion('How was your trip?'),
          _newRatingScale(),
          _divider(),
          EvalQuestion('What did you do?'),
          _activityPicker(),
          _divider(),
          TWRadioButtonQuestion(
              context: context,
              selectedValue: _selectedTimeWorth,
              onChanged: (value) => setState(() {
                    _selectedTimeWorth = value;
                  }),
              minLabel: 'All time was wasted',
              maxLabel: 'All time was worthwhile',
              questionText: 'Was your travel time worthwhile or wasted?'),
          _divider(),
          _customEvalQuestion(),
          _experienceFactorRater(),
          _divider(),
          TWRadioButtonQuestion(
              context: context,
              selectedValue: _selectedPrepLevel,
              onChanged: (value) => setState(() {
                    _selectedPrepLevel = value;
                  }),
              minLabel: 'I could have done more',
              maxLabel: 'I was well prepared',
              questionText: 'Looking back, how adequate was your preparation?'),
          _divider(),
          _tripNotes(),
          _divider(),
          TWFlatButton(
            inverted: false,
            context: context,
            buttonText: 'END TRIP',
            onPressed: () {
              setState(() {
                trip.status = 'completed';
                trip.save(context).then((trip) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Trip ended')));
                  Navigator.pop(context, trip);
                });
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _customEvalQuestion() {
    TextStyle style = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

    return Container(
      child: Column(
        children: [
          Row(
            children: [],
          ),
          Text('What made it ', style: style),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('wasted (', style: style),
              Icon(LineAwesomeIcons.thumbs_down),
              Text(') or worthwhile (', style: style),
              Icon(LineAwesomeIcons.thumbs_up),
              Text(')?', style: style)
            ],
          )
        ],
      ),
    );
  }

  Widget _experienceFactorRater() {
    return Container(
//      padding: EdgeInsets.symmetric(vertical: 5.0),
      height: 200.0,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(children: [
            _experienceFactorRating('Preparation with TimeWise',
                LineAwesomeIcons.app_store, isSelectedWithTimeWise),
            _experienceFactorRating('Preparation without TimeWise',
                LineAwesomeIcons.app_store, isSelectedWithoutTimeWise),
            _experienceFactorRating('Ability to do what you wanted',
                LineAwesomeIcons.raised_fist, isSelectedAbilityToDo),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(flex: 1, child: Icon(icon, size: 30.0)),
          Expanded(
              flex: 4,
              child: Text(
                label,
                style: TextStyle(fontSize: 16.0),
              )),
          Expanded(
            flex: 3,
            child: ToggleButtons(
              color: Colors.indigo[300],
              fillColor: Colors.indigo[300],
              borderColor: Colors.indigo[300],
              borderWidth: 2.0,
              selectedColor: Colors.white,
              selectedBorderColor: Colors.indigo[300],
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

  Widget _activityTile(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: 110.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
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

  Widget _divider() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Divider(),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _tripNotes() {
    return Container(
      child: Column(children: [
        EvalQuestion('What would you like to remember for this trip?'),
        SizedBox(
          height: 10.0,
        ),
        TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.edit,
                color: Colors.indigo,
              ),
            ),
            onChanged: (text) => {this.notes = text}),
      ]),
    );
  }
}
