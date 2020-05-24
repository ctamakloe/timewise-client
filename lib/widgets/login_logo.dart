import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'TimeWise', 
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),  
          SizedBox(width: 10.0), 
          Image.asset(
            'assets/images/logo.png',
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
