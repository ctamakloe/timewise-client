
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/components/detail_item.dart';

class TravelProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 30.0,),
          DetailItemText(
            detailIcon: LineAwesomeIcons.train,
            detailLabel: 'Trips',
            detailValue: '12',
          ),
          DetailItemDivider(),
          DetailItemText(
            detailIcon: LineAwesomeIcons.stopwatch,
            detailLabel: 'Average Duration',
            detailValue: '1H 34M',
          ),
          DetailItemDivider(),
        ],
      ),

    );
  }
}
