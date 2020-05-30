import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final Color iconColor;

  IconTile({@required this.icon, @required this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Icon(
        icon,
        size: 30,
        color: iconColor != null ? iconColor : null,
      )),
    );
  }
}
