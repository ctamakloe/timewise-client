import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:time_wise_app/models/trip.dart';

class CoverageChart extends StatelessWidget {
  final Trip trip;

  final int selection;

  CoverageChart(this.trip, this.selection);

  // get this from trip.data tripData = trip.data

  List<RouteData> _getTripData(int selected) {
    if (selected == 1) {
      return [
        RouteData(DateTime(2017, 9, 7, 17, 30), 1),
        RouteData(DateTime(2017, 9, 7, 17, 40), 2),
        RouteData(DateTime(2017, 9, 7, 17, 50), 3),
        RouteData(DateTime(2017, 9, 7, 18, 00), 3),
        RouteData(DateTime(2017, 9, 7, 18, 10), 4),
        RouteData(DateTime(2017, 9, 7, 18, 20), 5),
        RouteData(DateTime(2017, 9, 7, 18, 30), 5),
        RouteData(DateTime(2017, 9, 7, 18, 40), 5),
      ];
    } else if (selected == 2) {
      return [
        RouteData(DateTime(2017, 9, 7, 18, 50), 3),
        RouteData(DateTime(2017, 9, 7, 19, 00), 3),
        RouteData(DateTime(2017, 9, 7, 19, 10), 3),
        RouteData(DateTime(2017, 9, 7, 19, 20), 3),
      ];
    } else if (selected == 3) {
      return [
        RouteData(DateTime(2017, 9, 7, 19, 30), 1),
        RouteData(DateTime(2017, 9, 7, 19, 40), 3),
        RouteData(DateTime(2017, 9, 7, 19, 50), 3),
        RouteData(DateTime(2017, 9, 7, 20, 00), 2),
      ];
    } else {
      return [
        RouteData(DateTime(2017, 9, 7, 20, 10), 0),
        RouteData(DateTime(2017, 9, 7, 20, 20), 2),
        RouteData(DateTime(2017, 9, 7, 20, 30), 2),
        RouteData(DateTime(2017, 9, 7, 20, 40), 2),
        RouteData(DateTime(2017, 9, 7, 20, 50), 3),
        RouteData(DateTime(2017, 9, 7, 21, 00), 3),
        RouteData(DateTime(2017, 9, 7, 21, 10), 3),
        RouteData(DateTime(2017, 9, 7, 21, 20), 1),
        RouteData(DateTime(2017, 9, 7, 21, 30), 3),
        RouteData(DateTime(2017, 9, 7, 21, 40), 3),
        RouteData(DateTime(2017, 9, 7, 21, 50), 2),
        RouteData(DateTime(2017, 9, 7, 22, 00), 3),
        RouteData(DateTime(2017, 9, 7, 22, 10), 3),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//          border: Border(
//              right: BorderSide(
//        width: 3.0,
//        color: Colors.indigo,
//      )
//          )
//      ),
      child: Column(
        children: [
          RouteChart(_getTripData(this.selection)),
          SizedBox(height: 20.0),
          RouteStations(),
        ],
      ),
    );
  }
}

class RouteChart extends StatelessWidget {
  final List<RouteData> data;

  RouteChart(this.data);

  List<charts.Series<RouteData, DateTime>> _createVisualizationData() {
    return [
      charts.Series<RouteData, DateTime>(
          id: 'Route',
          colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
          domainFn: (RouteData dataPoint, _) => dataPoint.time,
          measureFn: (RouteData dataPoint, _) => dataPoint.strengthValue,
          data: data)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      child: charts.TimeSeriesChart(
        _createVisualizationData(),
        animate: true,
        domainAxis: new charts.DateTimeAxisSpec( ),
        defaultRenderer: charts.BarRendererConfig<DateTime>(
          minBarLengthPx: 499,
          strokeWidthPx: 10,
        ),

        defaultInteractions: false,
//          behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
      ),
    );
  }
}
//primaryMeasureAxis: charts.NumericAxisSpec(
//tickProviderSpec: new charts.BasicNumericTickProviderSpec(
//desiredTickCount: 5,
//),

class RouteStations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        width: 3.0,
        color: Colors.red,
      ))),
    );
  }
}

class RouteData {
  final DateTime time;
  final double strengthValue;

  RouteData(this.time, this.strengthValue);
}

//primaryMeasureAxis:
//new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
//domainAxis: new charts.OrdinalAxisSpec(
//// Make sure that we draw the domain axis line.
//showAxisLine: true,
//// But don't draw anything else.
////              renderSpec: new charts.NoneRenderSpec()
//),
