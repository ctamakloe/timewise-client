import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      )),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: _stationInfo(schedule.startStation.name,
                DateFormat.Hm().format(schedule.departureTime)),
          ),
          Flexible(
            flex: 1,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
          ),
          Flexible(
            flex: 3,
            child: _stationInfo(schedule.endStation.name,
                DateFormat.Hm().format(schedule.arrivalTime)),
          ),
        ],
      ),
    );
  }

  _stationInfo(String stationName, String time) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
//          width: 100.0,
          child: Text(
            stationName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
