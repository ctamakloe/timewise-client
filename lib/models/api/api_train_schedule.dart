import 'package:time_wise_app/models/station.dart';
import 'package:time_wise_app/models/train_schedule.dart';

class APITrainSchedule {
  int id;
  String startStationName;
  String startStationCode;
  String startTime;
  String endStationName;
  String endStationCode;
  String endTime;

  APITrainSchedule(
      {this.id,
        this.startStationName,
        this.startStationCode,
        this.startTime,
        this.endStationName,
        this.endStationCode,
        this.endTime});

  APITrainSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startStationName = json['start_station_name'];
    startStationCode = json['start_station_code'];
    startTime = json['start_time'];
    endStationName = json['end_station_name'];
    endStationCode = json['end_station_code'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_station_name'] = this.startStationName;
    data['start_station_code'] = this.startStationCode;
    data['start_time'] = this.startTime;
    data['end_station_name'] = this.endStationName;
    data['end_station_code'] = this.endStationCode;
    data['end_time'] = this.endTime;
    return data;
  }

  TrainSchedule toTrainSchedule() {
    return TrainSchedule(
      id: this.id,
      startStation: Station(code: this.startStationCode, name: this.startStationName),
      endStation: Station(code: this.endStationCode, name: this.endStationName),
      departureTime: DateTime.parse(this.startTime),
      arrivalTime: DateTime.parse(this.endTime)
    );
  }
}