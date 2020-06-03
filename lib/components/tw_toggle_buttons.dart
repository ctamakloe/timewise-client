import 'package:flutter/material.dart';

class TWToggleButton extends StatelessWidget {
  final double width;
  final Widget content;

  TWToggleButton({Key key, @required Widget child, @required double width})
      : content = child,
        width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content,
      ),
    );
  }
}
