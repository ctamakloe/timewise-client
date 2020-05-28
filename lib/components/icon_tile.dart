import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  IconTile({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Icon(
        icon,
        size: 30,
      )
//        child: Image(
//          image: AssetImage('assets/images/trips/train/$iconName.png'),
//          height: 30.0,
//          width: 30.0,
//        ),
          ),
    );
  }
}
