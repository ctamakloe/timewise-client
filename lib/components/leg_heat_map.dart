import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:time_wise_app/models/trip.dart';

class LegHeatMap extends StatelessWidget {
  final TripLeg tripLeg;
  final double cellHeight = 20;
  final String heatMaptype;

  LegHeatMap(this.tripLeg, this.heatMaptype);

  @override
  Widget build(BuildContext context) {
//    String legType = this.tripLeg.legType;

//    bool isStop = legType == 'stop';
//    bool isNotStop = !isStop;
    // compile a bunch of data columns to get the map for a leg
    return IntrinsicWidth(
      child: Container(
        height: 220.0,
        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
        child: Stack(
          children: [
            // Chart
//            if (isNotStop)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
//                height: 125.0,
//                child: _combineColumns(),
                child: _newCombineColumns(),
              ),
            ),

            /*
            // Start station label
            if (isNotStop)
              Align(
                alignment: Alignment(-1, .5),
                child: Container(
                    child: Text(
                  this.tripLeg.startStation,
                  style: TextStyle(fontSize: 12.0),
                )),
              ),

//             End station label
            if (isEndStop)
              Align(
                alignment: Alignment(1.0, 0),
                child: Container(
                    width: 200.0,
                    child: Text(
                      this.tripLeg.endStation,
                    )),
              ),
            */
          ],
        ),
      ),
    );
  }

  // GENERATORS
  _combineColumns() {
    // Start with an empty column with node for station
    List<Widget> columns = [
      _stationColumn(),
    ];

    // add data cells
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
      mainAxisSize: MainAxisSize.min,
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

  _nodeColumn() {
    return Column(
      children: [
        _nodeCell(),
        _emptyCell(),
        _emptyCell(),
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
          color = Colors.red[300];
        }
        break;
      case '2':
        {
          color = Colors.red[100];
        }
        break;
      case '3':
        {
          color = Colors.amber[200];
        }
        break;
      case '4':
        {
          color = Colors.green[100];
        }
        break;
      case '5':
        {
          color = Colors.green[300];
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
      alignment: Alignment(3, -.5),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: cellHeight,
      width: 50.0,
      child: Text(
        timeLabel,
//        textAlign: TextAlign.center,
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

/* New Combination */

  _newCombineColumns() {
    // Start with an empty column with node for station
    List<Widget> columns = [];

    bool isDepartureLeg = this.tripLeg.legType == 'departure';
    bool isArrivalLeg = this.tripLeg.legType == 'arrival';

    // the origin label to only first leg
//    if (isDepartureLeg)
//      columns.add(_newStationLabelColumn(this.tripLeg.startStation));

    // add node at the start of every trip leg
//    columns.add(_newStationNodeColumn(
//        this.tripLeg.startStation, this.tripLeg.stopTime));
    // TODO: removing this so i can add nodes as data cells

    this.tripLeg.dataCells.asMap().forEach((index, cell) {
      // for all legs, show station data column as first column
      if (index == 0)
        columns.add(_newStationDataColumn(this.tripLeg.startStation, cell));
      else {
        // for subsequent columns, if its an arrival leg, show station data
        // column for the last item. anything else show a regular data column
        if (isArrivalLeg && tripLeg.dataCells.length == index + 1)
          columns.add(_newStationDataColumn(this.tripLeg.endStation, cell));
        else
          columns.add(_newDataColumn(cell));
      }
      columns.add(SizedBox(width: 5.0));
    });

    // add data cells
//    this.tripLeg.dataCells.forEach((cell) {
//      columns.add(_newDataColumn(cell));
//      columns.add(SizedBox(width: 5.0));
//    });

    // add both node and label if it's the last leg
//    if (isArrivalLeg) {
//      columns.add(_newStationNodeColumn(
//          this.tripLeg.endStation, this.tripLeg.stopTime));
//      columns.add(_newStationLabelColumn(this.tripLeg.endStation));
//    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: columns,
    );
  }

  // this shows a data column at the station instead of a node
  _newStationDataColumn(String stationName, TripLegDataCell cell) {
    return Column(
      children: [
        _emptyCell(),
        _ratingCell(cell.rating),
        _newLabelCell(cell.timeLabel, true, true),
        RotatedBox(
          quarterTurns: 1,
          child: Container(
              alignment: Alignment.centerLeft,
              width: 130.0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(stationName))),
        ),
//        Expanded(
////          child: _newLabelCell('London St Pancras International'),
//          child: _newLabelCell('Wellingborough'),
//        )
      ],
    );
  }

  _newStationNodeColumn(String stationName, String time) {
    return Column(
      children: [
        _newNodeCell(),
        _emptyCell(),
        _newLabelCell(time, true, true),
        RotatedBox(
          quarterTurns: 1,
          child: Container(
              alignment: Alignment.centerLeft,
              width: 130.0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(stationName))),
        ),
//        Expanded(
////          child: _newLabelCell('London St Pancras International'),
//          child: _newLabelCell('Wellingborough'),
//        )
      ],
    );
  }

  _newStationLabelColumn(String labelText) {
    return Column(
      children: [
        _emptyCell(),
        Text(labelText),
        _emptyCell(),
        _emptyCell(),
      ],
    );
  }

  _newNodeCell() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: cellHeight,
          width: 50.0,
          color: Colors.white,
          child: Icon(
            LineAwesomeIcons.dot_circle,
            color: Colors.indigo,
          )),
    );
  }

  _newLabelCell(String labelText, bool station, bool bold) {
    return Container(
//      alignment: station ? Alignment(0, -.5) : Alignment(3, -.5),
//      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),// put this back after
      height: cellHeight,
      width: 50.0,
      child: Text(
        labelText,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  _newDataColumn(TripLegDataCell cell) {
    return Container(
      child: Column(
        children: [
          _emptyCell(),
          _ratingCell(cell.rating),
          _newLabelCell(cell.timeLabel, false, false),
          _emptyCell(),
        ],
      ),
    );
  }
}
