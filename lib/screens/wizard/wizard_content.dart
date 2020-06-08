import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_wise_app/components/train_schedule_tile.dart';
import 'package:time_wise_app/components/tw_autocomplete_textfield.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/components/tw_toggle_buttons.dart';
import 'package:time_wise_app/models/api/api_train_schedule.dart';
import 'package:time_wise_app/models/station.dart';
import 'package:time_wise_app/services/train_schedule_service.dart';
import 'package:time_wise_app/services/trip_service.dart';

class WizardContent extends StatefulWidget {
  @override
  _WizardContentState createState() => _WizardContentState();
}

class _WizardContentState extends State<WizardContent> {
  // stepper
  List<Step> _steps = [];
  int _currentStep = 0;

//  bool _complete = false;

  // form => step 1
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fromStationController = TextEditingController();
  TextEditingController _toStationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  // form => step 2
  int _selectedScheduleId = -1;

  // form => step 3
  TextEditingController _purposeController = TextEditingController();
  String _tripType;
  String _travelDirection;
  List<bool> _isSelectedDir = [false, false]; //[outbound, return]
  List<bool> _isSelectedType = [false, false]; // non-business, business

  // data
  Station startStation;
  Station endStation;

  bool isFirstStep() => _currentStep == 0;

  bool isLastStep() => _currentStep == _steps.length - 1;

  int nextStep() => _currentStep + 1;

  int lastStep() => _steps.length;

  next() {
//    _currentStep + 1 != _steps.length
//        ? goTo(_currentStep + 1)
//        : setState(() => _complete = true);

    if (nextStep() != lastStep()) {
      goTo(nextStep());
    } else {
//      trip = TripService.createTrip(_tripFormData)
//      if this returns a trip, navigate to trip page
//      else show message
      TripFormData _formData = TripFormData();
      _formData.scheduleId = _selectedScheduleId;
      _formData.tripPurpose = _purposeController.text;
      _formData.tripType = _tripType;
      _formData.travelDirection = _travelDirection;
      _formData.rating = '0';

      var tripService = TripService();

      tripService.createTrip(context, _formData).then((value) {
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, '/tripDetails', ModalRoute.withName('/'),
              arguments: value);
//          _complete = true;
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
    _travelDirection = '';
    _tripType = '';
  }

  @override
  Widget build(BuildContext context) {
    _steps = [
      _buildStepOne(),
      _buildStepTwo(),
      _buildStepThree(),
    ];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              key: this._formKey,
              child: Stepper(
                type: StepperType.vertical,
                steps: _steps,
                currentStep: _currentStep,
                onStepContinue: next,
                onStepCancel: cancel,
//                onStepTapped: (step) => goTo(step),
                controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue,
                        VoidCallback onStepCancel}) =>
                    Container(
                  height: 160.0,
                  padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TWFlatButton(
                        inverted: false,
                        context: context,
                        buttonText: isLastStep() ? 'CREATE TRIP PLAN' : 'NEXT',
                        onPressed: onStepContinue,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TWFlatButton(
                        inverted: true,
                        context: context,
                        buttonText: isFirstStep() ? 'CLEAR' : 'BACK',
                        onPressed: onStepCancel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  DateFormat _timeFormat = DateFormat.Hm();

  _buildStepOne() {
    return Step(
      title: const Text('Schedule'),
      isActive: _currentStep == 0 ? true : false,
      state: _currentStep == 0 ? StepState.editing : StepState.complete,
      content: Container(
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
      height: 300.0,
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

  _buildStepTwo() {
    return Step(
      title: const Text('Select Train'),
      isActive: _currentStep == 1 ? true : false,
      state: _currentStep == 1 ? StepState.editing : StepState.complete,
      content: _scheduleList.isNotEmpty
          ? _buildScheduleList(_scheduleList)
          : FutureBuilder(
              future: TrainScheduleService().getTrainSchedules(
                context,
                _fromStationController.text,
                _toStationController.text,
                _dateController.text,
                _timeController.text,
              ),
              builder: (context, schedulesSnap) {
                if (schedulesSnap.data == null)
                  return Container(
                    height: 300.0,
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
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Trip Purpose', hintText: 'Day trip to ...'),
              controller: _purposeController,
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Travel Direction',
                  style: TextStyle(fontSize: 16.0),
                ),
                ToggleButtons(
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
                      width: 90.0,
                    ),
                    TWToggleButton(
                      child: Text(
                        'Return',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      width: 90.0,
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
                )
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trip Type',
                  style: TextStyle(fontSize: 16.0),
                ),
                ToggleButtons(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
