import 'package:intl/intl.dart';

class Trip {
  int id;
  String origin;
  String destination;
  String departsAt;
  String arrivesAt;
  String purpose;
  String description;
  String status;

  Trip(
      {this.id,
      this.origin,
      this.destination,
      this.departsAt,
      this.arrivesAt,
      this.purpose,
      this.description,
      this.status}) {
//    initializeDateFormatting('de_DE', null).then(formatDates);
  }

  String get title => '${this.origin} to ${this.destination}';

  String get schedule {

    String dt = DateFormat.Hm().format(DateTime.parse(departsAt));
    String at = DateFormat.Hm().format(DateTime.parse(arrivesAt));
    return '$dt - $at';
  }

  String get date => DateFormat.yMMMMd().format(DateTime.parse(departsAt));

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    origin = json['origin'];
    destination = json['destination'];
    departsAt = json['departs_at'];
    arrivesAt = json['arrives_at'];
    purpose = json['purpose'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['departs_at'] = this.departsAt;
    data['arrives_at'] = this.arrivesAt;
    data['purpose'] = this.purpose;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }

  static List<Trip> sampleTrips = tripJson.map<Trip>((json) => Trip.fromJson(json)).toList();
}

List<Map<String, Object>> tripJson = [
  {
    "id": 1,
    "origin": "Manchester Picadilly (MAN)",
    "destination": "London St Pancras International (STP)",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "purpose": "leisure",
    "description": "Visit Sean at Uni",
    "status": "upcoming"
  },
  {
    "id": 2,
    "origin": "Nottingham (NOT)",
    "destination": "London St Pancras International (STP)",
    "departs_at": "2020-05-25T07:10:46.120Z",
    "arrives_at": "2000-01-01T09:05:46.120Z",
    "purpose": "business",
    "description": "Meeting at ABC head office",
    "status": "upcoming"
  },
  {
    "id": 3,
    "origin": "London St Pancras International (STP)",
    "destination": "Nottingham (NOT)",
    "departs_at": "2020-05-25T18:15:46.120Z",
    "arrives_at": "2000-01-01T20:25:46.120Z",
    "purpose": "business",
    "description": "Return: Meeting at ABC head office",
    "status": "upcoming"
  }
];

