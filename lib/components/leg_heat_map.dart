import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/models/trip.dart';

class LegHeatMap extends StatelessWidget {
  final TripLeg tripLeg;
  final double cellHeight = 20;

  LegHeatMap(this.tripLeg);

  @override
  Widget build(BuildContext context) {
    // compile a bunch of data columns to get the map for a leg
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          child: Stack(
            children: [
              // Chart
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 125.0,
                  child: _combineColumns(),
                ),
              ),
              // Start station label
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: 200.0,
                    child: Text(
                      this.tripLeg.startStation,
                    )),
              ),
              // End station label
              if (tripLeg.legType == 'arrival')
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      width: 200.0,
                      child: Text(
                        this.tripLeg.endStation,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // GENERATORS
  _combineColumns() {
    List<Widget> columns = [
      _stationColumn(),
    ];

    this.tripLeg.dataCells.forEach((cell) {
      columns.add(_dataColumn(cell));
      columns.add(SizedBox(width: 5.0));
    });

    if (tripLeg.legType == 'arrival') {
      columns.add(
        _stationColumn(),
      );
    }

    return Row(
      children: columns,
    );
  }

  // COLUMNS

  // represents a strength/time pair
  _dataColumn(TripLegDataCell cell) {
    return Column(
      children: [
        _ratingCell(cell.rating),
        _labelCell(cell.timeLabel),
        _lineCell(),
      ],
    );
  }

  // represents the stations on the route
  _stationColumn() {
    return Column(
      children: [
        _emptyCell(),
        _emptyCell(),
        _nodeCell(),
      ],
    );
  }

  // CELLS

  _ratingCell(String rating) {
    Color color;
    switch (rating) {
      case '0':
        {
//        color = Colors.red[300];
          color = Colors.grey[200];
        }
        break;
      case '1':
        {
//        color = Colors.red[300];
          color = Colors.green[100];
        }
        break;
      case '2':
        {
//        color = Colors.red[100];
          color = Colors.green[200];
        }
        break;
      case '3':
        {
//        color = Colors.amber[300];
          color = Colors.green[300];
        }
        break;
      case '4':
        {
//        color = Colors.green[100];
          color = Colors.green[400];
        }
        break;
      case '5':
        {
//        color = Colors.green[300];
          color = Colors.green[500];
        }
        break;
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: cellHeight,
      width: 50.0,
      color: color,
    );
  }

  _labelCell(String timeLabel) {
    return Container(
      alignment: Alignment(5, -.5),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: cellHeight,
      width: 50.0,
      child: Text(
        timeLabel,
      ),
    );
  }

  _nodeCell() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: cellHeight,
          width: 50.0,
          color: Colors.white,
          child: Icon(
            LineAwesomeIcons.dot_circle,
            color: Colors.indigo,
          )),
    );
  }

  _lineCell() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        height: cellHeight,
        width: 50.0,
        color: Colors.white,
        child: Divider(
          color: Colors.indigo,
          thickness: 3.0,
          height: 0,
        ));
  }

  _emptyCell() {
    return Container(
      height: cellHeight,
      width: 50.0,
      color: Colors.transparent,
    );
  }
}
