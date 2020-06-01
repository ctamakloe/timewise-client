import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/train_schedule_tile.dart';
import 'package:time_wise_app/components/tw_autocomplete_textfield.dart';
import 'package:time_wise_app/components/tw_datetime.dart';
import 'package:time_wise_app/models/train_schedule.dart';

class WizardContent extends StatefulWidget {
  @override
  _WizardContentState createState() => _WizardContentState();
}

class _WizardContentState extends State<WizardContent> {
  List<TrainSchedule> schedules = TrainSchedule.getTrainSchedules();

  List<Step> steps = [];

  int currentStep = 0;
  bool complete = false;
  StepperType stepperType = StepperType.horizontal;

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  @override
  Widget build(BuildContext context) {

    steps = [
      _stepOneContent(),
      _stepTwoContent(),
      _stepThreeContent(),
    ];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stepper(
                type: stepperType,
                steps: steps,
                currentStep: currentStep,
                onStepContinue: next,
                onStepCancel: cancel,
                onStepTapped: (step) => goTo(step)),
          ),
        ],
      ),
    );
  }

  _stepOneContent() {
    TextEditingController _fromStationController =
    TextEditingController(text: '');
    TextEditingController _toStationController = TextEditingController(text: '');
    return Step(
      title: const Text('Schedule'),
      isActive: true,
      state: StepState.complete,
      content: Container(
        height: 420.0,
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
                    child: TWDateField(labelText: 'Date'),
                  ),
                  SizedBox(width: 20.0),
                  Flexible(
                    flex: 1,
                    child: TWTimeField(
                      labelText: 'Time',
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

  _stepTwoContent() {
    return Step(
      title: const Text('Select Train'),
      isActive: false,
      state: StepState.editing,
      content: Container(
        height: 420.0,
        child: ListView.builder(
            itemCount: this.schedules.length,
            itemBuilder: (BuildContext context, int index) {
              return TrainScheduleTile(schedule: this.schedules[index]);
            }),
      ),
    );
  }

}
_stepThreeContent() {
  List<bool> isSelected = [false, false];
  return Step(
    title: const Text('Trip details'),
    isActive: false,
    state: StepState.editing,
    content: Container(
      height: 420.0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Travel Direction', style: TextStyle(fontSize: 16.0), ),
                ToggleButtons(
                  color: Colors.indigo,
                  fillColor: Colors.indigo,
                  borderColor: Colors.indigo,
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.indigo,
                  borderRadius: BorderRadius.circular(5.0),
                  children: [
                    Container(
                      width: 110.0,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Outbound'),
                      ),
                    ),
                    Container(
                      width: 110.0,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Return'),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                  },
                  isSelected: isSelected,
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trip Type', style: TextStyle(fontSize: 16.0), ),
                ToggleButtons(
                  color: Colors.indigo,
                  fillColor: Colors.indigo,
                  borderColor: Colors.indigo,
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.indigo,
                  borderRadius: BorderRadius.circular(5.0),
                  children: [
                    Container(
                      width: 110.0,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Business'),
                      ),
                    ),
                    Container(
                      width: 110.0,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Non-business'),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                  },
                  isSelected: isSelected,
                ),
              ],
            ),

            SizedBox(height: 20.0),

            TextFormField(
              decoration: InputDecoration(labelText: 'Trip Purpose'),
            ),
          ],
        ),
    ),
  );
}


