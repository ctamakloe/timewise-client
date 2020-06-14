import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_wise_app/components/app_bar_title.dart';
import 'package:time_wise_app/components/screen_section.dart';
import 'package:time_wise_app/components/train_schedule_tile.dart';
import 'package:time_wise_app/components/tw_autocomplete_textfield.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/components/tw_toggle_buttons.dart';
import 'package:time_wise_app/models/api/api_train_schedule.dart';
import 'package:time_wise_app/models/screen_section_data.dart';
import 'package:time_wise_app/screens/trips/trip_details_screen.dart';
import 'package:time_wise_app/services/train_schedule_service.dart';
import 'package:time_wise_app/services/trip_service.dart';
import 'package:time_wise_app/state_container.dart';

class TripPlannerScreen extends StatefulWidget {
  final Function() onTripCreated;

  TripPlannerScreen({Key key, @required this.onTripCreated}) : super(key: key);

  @override
  _TripPlannerScreenState createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  // stepper
  List<Step> _steps = [];
  int _currentStep = 0;

  static DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static DateFormat _timeFormat = DateFormat.Hm();

//  bool _complete = false;

  // form => step 1
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fromStationController = TextEditingController();
  TextEditingController _toStationController = TextEditingController();
  TextEditingController _dateController =
      TextEditingController(text: _dateFormat.format(DateTime.now()));
  TextEditingController _timeController =
      TextEditingController(text: _timeFormat.format(DateTime.now()));

  // form => step 2
  int _selectedScheduleId = -1;

  // form => step 3
  TextEditingController _purposeController = TextEditingController();
  String _rating = '0';
  String _tripType = 'non-business';
  String _travelDirection = 'outbound';
  List<bool> _isSelectedDir = [true, false]; //[outbound, return]
  List<bool> _isSelectedType = [true, false];

  double _stepContainerHeight;

  bool isFirstStep() => _currentStep == 0;

  bool isLastStep() => _currentStep == _steps.length - 1;

  int nextStep() => _currentStep + 1;

  int lastStep() => _steps.length;

  next() {
    if (nextStep() != lastStep()) {
      goTo(nextStep());
    } else {
      TripFormData _formData = TripFormData();
      _formData.scheduleId = _selectedScheduleId;
      _formData.tripPurpose = _purposeController.text;
      _formData.tripType = _tripType;
      _formData.travelDirection = _travelDirection;
      _formData.rating = _rating;

      var tripService = TripService();

      tripService.createTrip(context, _formData).then((trip) {
        setState(() {
          // Show newly created trip details
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TripDetailsScreen(
                      trip: trip,
                      onTripChanged: widget.onTripCreated,
                    )),
            ModalRoute.withName('/'),
          );

          // refresh trip list from server
          StateContainer.of(context).loadTrips().then((trips) {
            widget.onTripCreated();
          });
        });
      });
    }
  }

  goTo(int step) {
    setState(() {
      if (_currentStep == 0) _scheduleList = []; // clear schedules

      _currentStep = step;
    });
  }

  cancel() {
    if (_currentStep == 0) resetForm();

    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
  }

  resetForm() {
    _formKey.currentState.reset();
    _scheduleList = [];
    _fromStationController.clear();
    _toStationController.clear();
    _timeController.clear();
    _dateController.clear();
    _purposeController.clear();
    _travelDirection = 'outbound';
    _tripType = 'non-business';
  }

  Widget _buildTripPlanner() {
    _steps = [
      _buildStepOne(),
      _buildStepTwo(),
      _buildStepThree(),
    ];

    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: this._formKey,
          child: Stepper(
            type: StepperType.horizontal,
            steps: _steps,
            currentStep: _currentStep,
            onStepContinue: next,
            onStepCancel: cancel,
//                onStepTapped: (step) => goTo(step),
            controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                Container(
//            height: 100.0,
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: TWFlatButton(
                      inverted: false,
                      context: context,
                      buttonText: isLastStep() ? 'FINISH' : 'NEXT',
                      onPressed: onStepContinue,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: TWFlatButton(
                      inverted: true,
                      context: context,
                      buttonText: isFirstStep() ? 'CLEAR' : 'BACK',
                      onPressed: onStepCancel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildStepOne() {
    return Step(
      title: const Text('Schedule'),
      isActive: _currentStep == 0 ? true : false,
      state: _currentStep == 0 ? StepState.editing : StepState.complete,
      content: Container(
        height: _stepContainerHeight,
        child: Column(
          children: [
            TWStationAutoCompleteTextField(
              formController: _fromStationController,
              label: 'From',
            ),
            TWStationAutoCompleteTextField(
              formController: _toStationController,
              label: 'To',
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: DateTimeField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 30, 10, 10),
                        labelText: 'Date',
                      ),
                      initialValue: DateTime.now(),
                      format: _dateFormat,
                      cursorColor: Colors.indigo,
                      controller: _dateController,
                      onChanged: (value) {
                        if (value != null)
                          _dateController.text = _dateFormat.format(value);
                      },
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData(
                                primarySwatch: Colors.indigo,
                              ),
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Flexible(
                    flex: 1,
                    child: DateTimeField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 30, 10, 10),
                        labelText: 'Time',
                      ),
                      initialValue: DateTime.now(),
                      format: _timeFormat,
                      cursorColor: Colors.indigo,
                      controller: _timeController,
                      onChanged: (value) {
                        if (value != null)
                          _timeController.text = _timeFormat.format(value);
                      },
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData(
                                  primarySwatch: Colors.indigo,
                                ),
                                child: child,
                              );
                            });
//                        if (time != null) return DateTimeField.convert(time);

                        return DateTime.now();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<APITrainSchedule> _scheduleList = [];

  _buildScheduleList(list) {
    return Container(
      height: _stepContainerHeight,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedScheduleId = list[index].id;
                  });
                },
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Radio(
                        value: list[index].id,
                        groupValue: _selectedScheduleId,
//                          onChanged: (value) => () { },
                      ),
                    ),
                    Flexible(
                        flex: 5,
                        child: TrainScheduleTile(
                          schedule: list[index].toTrainSchedule(),
                        ))
                  ],
                ),
              );
            }),
      ),
    );
  }

  String _getStationCode(TextEditingController controller) {
    String code = '';
    String codeWithLastBracket = controller.text.split('(').last;
    // remove ending braces
    code = codeWithLastBracket.replaceAll(')', '');
    return code;
  }

  _buildStepTwo() {
    return Step(
      title: const Text('Train'),
      isActive: _currentStep == 1 ? true : false,
      state: _currentStep == 1 ? StepState.editing : StepState.complete,
      content: _scheduleList.isNotEmpty
          ? _buildScheduleList(_scheduleList)
          : FutureBuilder(
              future: TrainScheduleService().getTrainSchedules(
                context,
                _getStationCode(_fromStationController),
                _getStationCode(_toStationController),
                _dateController.text,
                _timeController.text,
              ),
              builder: (context, schedulesSnap) {
                if (schedulesSnap.data == null)
                  return Container(
                    height: _stepContainerHeight,
                    child: Center(
                      child: Text(
                        'Unable to retrieve train schedules!',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  );

                if (schedulesSnap.connectionState == ConnectionState.none &&
                    schedulesSnap.hasData == null) {
                  return Container();
                }

                _scheduleList = schedulesSnap.data;
                return _buildScheduleList(_scheduleList);
              },
            ),
    );
  }

  _buildStepThree() {
    return Step(
      title: const Text('Trip details'),
      isActive: _currentStep == 2 ? true : false,
      state: _currentStep == 2 ? StepState.editing : StepState.complete,
      content: Container(
        height: _stepContainerHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Reason for travelling',
                  hintText: 'Day trip to ...'),
              controller: _purposeController,
            ),
            SizedBox(height: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direction of trip',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: ToggleButtons(
                    color: Colors.indigo,
                    fillColor: Colors.indigo[300],
                    borderColor: Colors.indigo[300],
                    selectedColor: Colors.white,
                    selectedBorderColor: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(5.0),
                    children: [
                      TWToggleButton(
                        child: Text(
                          'Outbound',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        width: 110.0,
                      ),
                      TWToggleButton(
                        child: Text(
                          'Return',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        width: 110.0,
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < _isSelectedDir.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _isSelectedDir[buttonIndex] = true;
                          } else {
                            _isSelectedDir[buttonIndex] = false;
                          }
                        }
                        this._travelDirection =
                            _isSelectedDir[0] == true ? 'outbound' : 'return';
                      });
                    },
                    isSelected: _isSelectedDir,
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trip Type',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: ToggleButtons(
                    color: Colors.indigo,
                    fillColor: Colors.indigo[300],
                    borderColor: Colors.indigo[300],
                    selectedColor: Colors.white,
                    selectedBorderColor: Colors.indigo[300],
                    borderRadius: BorderRadius.circular(5.0),
                    children: [
                      TWToggleButton(
                        child: Text('Non-Business'),
                        width: 110.0,
                      ),
                      TWToggleButton(
                        child: Text('Business'),
                        width: 110.0,
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < _isSelectedType.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            _isSelectedType[buttonIndex] = true;
                          } else {
                            _isSelectedType[buttonIndex] = false;
                          }
                        }
                        this._tripType = _isSelectedType[0] == true
                            ? 'non-business'
                            : 'business';
                      });
                    },
                    isSelected: _isSelectedType,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _stepContainerHeight = MediaQuery.of(context).size.height * .42;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: TimeWiseAppBar(title: 'Trip Planner')),
      body: ScreenSection(
        sectionTitle: 'PLAN A TRIP',
        sectionAction: SectionAction(),
        sectionContent: _buildTripPlanner(),
      ),
    );
  }
}
