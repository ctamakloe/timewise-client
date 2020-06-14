import 'package:flutter/material.dart';

class TWFlatButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final bool inverted;

  const TWFlatButton({
    Key key,
    @required this.context,
    @required this.buttonText,
    @required this.onPressed,
    this.inverted,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: FlatButton(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
//          shape: OutlineInputBorder(
//            borderSide: BorderSide(
//                color: inverted ? Colors.indigo[300] : Colors.white, width: 2),
//            borderRadius: BorderRadius.circular(5),
//          ),
          padding: const EdgeInsets.all(15.0),
          textColor: this.inverted ? Colors.indigo : Colors.white,
          color: this.inverted ? Colors.white : Colors.indigo[300],
          onPressed: onPressed,
        ));
  }
}
