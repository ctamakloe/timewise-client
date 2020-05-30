import 'package:flutter/material.dart';

class EvalQuestion extends StatelessWidget {
  final String questionText;

  EvalQuestion(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        this.questionText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
