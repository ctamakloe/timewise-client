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
  List<TripLeg> tripLegs = sampleTripLegs;

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

  static List<Trip> sampleInProgressTrips =
      inProgressTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<Trip> sampleUpcomingTrips =
      upcomingTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<Trip> sampleCompleteTrips =
      completeTripsJson.map<Trip>((json) => Trip.fromJson(json)).toList();

  static List<TripLeg> sampleTripLegs = [
    TripLeg(
        startStation: 'Nottigham',
        endStation: 'London St Pancras Intl',
        legType: 'departure', // departure, transit, arrival
        dataCells: [
          TripLegDataCell('10:00', 10, '1'),
          TripLegDataCell('10:10', 20, '2'),
          TripLegDataCell('10:20', 30, '3'),
          TripLegDataCell('10:30', 30, '0'),
        ] // <TripLegDataCell>[]
        ),
    TripLeg(
        startStation: 'London St Pancras Intl',
        endStation: 'Manchester Picadilly (MAN)',
        legType: 'transit', // departure, transit, arrival
        dataCells: [
          TripLegDataCell('10:40', 40, '2'),
          TripLegDataCell('10:50', 50, '3'),
          TripLegDataCell('11:00', 10, '1'),
          TripLegDataCell('11:10', 20, '0'),
          TripLegDataCell('11:20', 30, '0'),
          TripLegDataCell('11:30', 30, '1'),
          TripLegDataCell('11:40', 40, '2'),
          TripLegDataCell('11:50', 50, '3'),
        ] // <TripLegDataCell>[]
        ),
    TripLeg(
        startStation: 'Manchester Picadilly (MAN)',
        endStation: 'East Midlands Airport (EMA)',
        legType: 'arrival', // departure, transit, arrival
        dataCells: [
          TripLegDataCell('12:00', 10, '1'),
          TripLegDataCell('12:10', 20, '0'),
          TripLegDataCell('12:20', 30, '0'),
          TripLegDataCell('12:30', 30, '1'),
          TripLegDataCell('12:40', 40, '2'),
          TripLegDataCell('12:50', 50, '3'),
        ] // <TripLegDataCell>[]
        ),
  ];
}

class TripLeg {
  String startStation;
  String endStation;
  String legType;
  List<TripLegDataCell> dataCells;

  TripLeg({
    this.startStation, // Nottingham
    this.endStation, // London St Pancras Intl
    this.legType, // departure, transit, arrival
    this.dataCells, // <TripLegDataCell>[]
  });
// NB: create a var legDuration => used on server side to calculate no. of cells to be
// generated
}

class TripLegDataCell {
  String timeLabel;
  int duration;
  String rating;

  TripLegDataCell(this.timeLabel, this.duration, this.rating);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

List<Map<String, Object>> upcomingTripsJson = [
  {
    "id": 1,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "purpose": "leisure",
    "description": "Visit Sean at Uni",
    "status": "in-progress"
  },
];

List<Map<String, Object>> inProgressTripsJson = [
  {
    "id": 2,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "business",
    "description": "Return: Meeting at ABC Head Office",
    "status": "upcoming"
  },
  {
    "id": 3,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "leisure",
    "description": "Vegan meet-up in Notts",
    "status": "upcoming"
  },
  {
    "id": 4,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "business",
    "description": "SXSW Conference",
    "status": "upcoming"
  }
];

List<Map<String, Object>> completeTripsJson = [
  {
    "id": 5,
//    "origin": "Manchester Picadilly (MAN)",
//    "destination": "London St Pancras International (STP)",
    "origin": "Manchester Picadilly",
    "destination": "London St Pancras International",
    "departs_at": "2020-06-02T11:05:46.120Z",
    "arrives_at": "2000-01-01T14:05:46.120Z",
    "purpose": "leisure",
    "description": "Visit Sean at Uni",
    "status": "complete"
  },
  {
    "id": 6,
    "origin": "Nottingham",
    "destination": "London St Pancras International",
    "departs_at": "2020-05-25T07:10:46.120Z",
    "arrives_at": "2000-01-01T09:05:46.120Z",
    "purpose": "business",
    "description": "Meeting at ABC head office",
    "status": "complete"
  },
  {
    "id": 7,
    "origin": "london st pancras international",
    "destination": "nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "business",
    "description": "Return: Meeting at ABC Head Office",
    "status": "complete"
  },
  {
    "id": 8,
    "origin": "Manchester Picadilly",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "leisure",
    "description": "Vegan meet-up in Notts",
    "status": "complete"
  },
  {
    "id": 9,
    "origin": "Reading",
    "destination": "Nottingham",
    "departs_at": "2020-12-25T18:15:46.120Z",
    "arrives_at": "2020-12-25T20:25:46.120Z",
    "purpose": "business",
    "description": "SXSW Conference",
    "status": "complete"
  }
];
