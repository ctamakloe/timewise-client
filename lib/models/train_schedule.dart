import 'package:time_wise_app/models/station.dart';

class TrainSchedule {
  final Station startStation;
  final Station endStation;
  final DateTime arrivalTime;
  final DateTime departureTime;

  TrainSchedule(this.startStation, this.endStation, this.departureTime,
      this.arrivalTime);

  static List<TrainSchedule> getTrainSchedules() {
    List<TrainSchedule> list = [];

    list.add(TrainSchedule(Station.getStations()[0], Station.getStations()[1],
        DateTime.now().add(Duration()),
        DateTime.now().add(Duration(hours: 2, minutes: 30))));

    list.add(TrainSchedule(Station.getStations()[0], Station.getStations()[1],
        DateTime.now().add(Duration(hours: 1)),
        DateTime.now().add(Duration(hours: 3, minutes: 30))));

    list.add(TrainSchedule(Station.getStations()[0], Station.getStations()[1],
        DateTime.now().add(Duration(hours: 2)),
        DateTime.now().add(Duration(hours: 4, minutes: 30))));

    list.add(TrainSchedule(Station.getStations()[0], Station.getStations()[1],
        DateTime.now().add(Duration(hours: 3)),
        DateTime.now().add(Duration(hours: 6, minutes: 30))));

    list.add(TrainSchedule(Station.getStations()[0], Station.getStations()[1],
        DateTime.now().add(Duration(hours: 4)),
        DateTime.now().add(Duration(hours: 8, minutes: 30))));

    return list;
  }
}
