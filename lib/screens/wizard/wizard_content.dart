import 'package:flutter/material.dart';
import 'package:time_wise_app/components/train_schedule_tile.dart';
import 'package:time_wise_app/components/tw_autocomplete_textfield.dart';
import 'package:time_wise_app/components/tw_datetime.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';
import 'package:time_wise_app/components/tw_toggle_buttons.dart';
import 'package:time_wise_app/models/train_schedule.dart';

class WizardContent extends StatefulWidget {
  @override
  _WizardContentState createState() => _WizardContentState();
}

class _WizardContentState extends State<WizardContent> {
  // stepper
  List<Step> _steps = [];
  int _currentStep = 0;
  bool _complete = false;

  // form => step 1
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fromStationController =
      TextEditingController(text: '');
  TextEditingController _toStationController = TextEditingController(text: '');
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _timeController = TextEditingController(text: '');
  // form => step 2
  int _selectedScheduleId = -1;
  // form => step 3
  TextEditingController _purposeController = TextEditingController(text: '');
  List<bool> _isSelectedDir = [false, false];
  List<bool> _isSelectedType = [false, false];

  // data
  List<TrainSchedule> _scheduleList = TrainSchedule.getTrainSchedules(); // TODO: get from server using date + time

  // planner variables :
  // originStationCode
  // destinationStationCode
  // * date + time => go to server and get trainSchedules
  // trainSchedule: departureTime, arrivalTime, id
  // travelDirection
  // tripType
  // tripPurpose

  bool firstStep() => _currentStep == 0;

  bool lastStep() => _currentStep == _steps.length - 1;

  next() {
    _currentStep + 1 != _steps.length
        ? goTo(_currentStep + 1)
        : setState(() => _complete = true);
  }

  goTo(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  cancel() {
    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
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
                onStepTapped: (step) => goTo(step),
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
                        buttonText: lastStep() ? 'SAVE' : 'NEXT',
                        onPressed: onStepContinue,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TWFlatButton(
                        inverted: true,
                        context: context,
                        buttonText: firstStep() ? 'CANCEL' : 'BACK',
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
                    child: TWDateField(
                      labelText: 'Date',
                      formController: _dateController,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Flexible(
                    flex: 1,
                    child: TWTimeField(
                      labelText: 'Time',
                      formController: _timeController,
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

  _buildStepTwo() {
    return Step(
        title: const Text('Select Train'),
        isActive: _currentStep == 1 ? true : false,
        state: _currentStep == 1 ? StepState.editing : StepState.complete,
        content: Container(
          height: 300.0,
          child: Scrollbar(
            child: ListView.builder(
                itemCount: _scheduleList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedScheduleId = _scheduleList[index].id;
                      });
                    },
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Radio(
                            value: _scheduleList[index].id,
                            groupValue: _selectedScheduleId,
//                          onChanged: (value) => () { },
                          ),
                        ),
                        Flexible(
                            flex: 5,
                            child: TrainScheduleTile(
                              schedule: _scheduleList[index],
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ));
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
                      child: Text('Business'),
                      width: 110.0,
                    ),
                    TWToggleButton(
                      child: Text('Non-Business'),
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
