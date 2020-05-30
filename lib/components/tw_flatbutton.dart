import 'package:flutter/material.dart';

class TWFlatButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const TWFlatButton({
    Key key,
    @required this.context,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child:
      FlatButton(
        color: Colors.indigo[300],
        textColor: Colors.white,
        child: Text(
          buttonText,
          style: TextStyle(),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
