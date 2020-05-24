import 'package:flutter/material.dart';

class LoginNavigationLink extends StatelessWidget {
  final String label;
  final Function ontap;

  LoginNavigationLink({this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: ontap,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ));

    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.all(12.0),
    //     child: InkWell(
    //       onTap: ontap,
    //       child: Text(
    //         label,
    //         style: TextStyle(
    //           fontSize: 16.0,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
