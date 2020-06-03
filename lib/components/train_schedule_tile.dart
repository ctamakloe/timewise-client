import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/models/train_schedule.dart';

class TrainScheduleTile extends StatelessWidget {
  final TrainSchedule schedule;

  TrainScheduleTile({
    @required TrainSchedule schedule,
  }) : schedule = schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
        )
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stationTime(schedule.startStation.name,
              DateFormat.Hm().format(schedule.departureTime)),
          Icon(
            Icons.arrow_forward,
            color: Colors.grey,
          ),
          _stationTime(schedule.endStation.name,
              DateFormat.Hm().format(schedule.arrivalTime)),
        ],
      ),
    );
  }

  _stationTime(String stationName, String time) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0,),
        Text(
          stationName,
          style: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
