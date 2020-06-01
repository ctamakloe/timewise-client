import 'package:flutter/material.dart';

class DetailItemText extends StatelessWidget {
  final String detailLabel;
  final String detailValue;
  final IconData detailIcon;

  DetailItemText({this.detailLabel, this.detailValue, this.detailIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: Icon(detailIcon, size: 25)),
          Expanded(flex: 4, child: Text(detailLabel)),
          Expanded(
            flex: 2,
            child: Text(
              detailValue,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class DetailItemDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.0,
      height: 40.0,
    );
  }
}
