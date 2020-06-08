import 'package:flutter/material.dart';
import 'package:time_wise_app/components/eval_question.dart';
import 'package:time_wise_app/components/tw_flatbutton.dart';

class TWRadioButtonQuestion extends StatefulWidget {
  final BuildContext context;
  final String minLabel;
  final String maxLabel;
  final String questionText;
  final Function onChanged;
  int selectedValue;

  TWRadioButtonQuestion(
      {this.selectedValue,
      this.context,
      this.minLabel,
      this.maxLabel,
      this.questionText,
      this.onChanged});

  @override
  _TWRadioButtonQuestionState createState() => _TWRadioButtonQuestionState();
}

class _TWRadioButtonQuestionState extends State<TWRadioButtonQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//        EvalQuestion(''),
        EvalQuestion(widget.questionText),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Radio(
                    value: 1,
                    activeColor: Colors.indigo[300],
                    groupValue: widget.selectedValue,
                    onChanged: widget.onChanged,
                  ),
                  Radio(
                    activeColor: Colors.indigo[300],
                    value: 2,
                    groupValue: widget.selectedValue,
                    onChanged: widget.onChanged,
                  ),
                  Radio(
                    activeColor: Colors.indigo[300],
                    value: 3,
                    groupValue: widget.selectedValue,
                    onChanged: widget.onChanged,
                  ),
                  Radio(
                    activeColor: Colors.indigo[300],
                    value: 4,
                    groupValue: widget.selectedValue,
                    onChanged: widget.onChanged,
                  ),
                  Radio(
                    activeColor: Colors.indigo[300],
                    value: 5,
                    groupValue: widget.selectedValue,
                    onChanged: widget.onChanged,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.0,
                    child: Text(widget.minLabel, textAlign: TextAlign.center,)),
                Container(
                    width: 100.0,
                    child: Text(widget.maxLabel, textAlign: TextAlign.center,)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
